local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local packages = ReplicatedStorage.Packages
local Flipper = require(packages.Flipper)
local Llama = require(packages.Llama)
local Roact = require(packages.Roact)

local CardPositionCache = require(ReplicatedStorage.Modules.CardPositionCache)

local components = ReplicatedStorage.Components
local Icon = require(components.Icon)
local Signature = require(components.Signature)
local TableContext = require(components.TableContext)

local Card = Roact.Component:extend("Card")

function Card:init()
	self.instance = Roact.createRef()
	self.targetInstance = Roact.createRef()

	local props = self.props
	local playerId = props.playerId
	local signature = props.signature

	local cachedPosition = CardPositionCache:get(signature, playerId)

	if cachedPosition then
		self:setState({
			needsAnimation = true
		})
		self.startPosition = cachedPosition
		self.position, self.setPosition = Roact.createBinding(UDim2.new(0, cachedPosition.position.X, 0, cachedPosition.position.Y))
		self.rotation, self.setRotation = Roact.createBinding(cachedPosition.rotation)
		self.motor = Flipper.GroupMotor.new({
			rotation = cachedPosition.rotation;
			X = cachedPosition.position.X;
			Y = cachedPosition.position.Y;
		})
		self.motor:onStep(function(values)
			self.setPosition(UDim2.new(0, values.X, 0, values.Y))
			self.setRotation(values.rotation)
		end)
		self.motor:onComplete(function()
			self.position = nil
			self.rotation = nil
			self:setState({
				needsAnimation = false
			})
		end)
	end
end

function Card:render()
	local state = self.state
	local needsAnimation = state.needsAnimation

	local props = self.props
	local anchorPoint = props.anchorPoint
	local direction = props.direction
	local onClick = props.onClick
	local position = props.position
	local rotation = props.rotation
	local selected = props.selected
	local signature = props.signature
	local zIndex = props.zIndex

	local additionalChildren
	local additionalProps

	if direction == Enums.CardDirection.Up then
		additionalProps = {
			BackgroundColor3 = Color3.new(1, 1, 1);
		}
		additionalChildren = {
			BottomSignature = Roact.createElement(Signature, {
				anchorPoint = Vector2.new(1, 1);
				position = UDim2.new(1, 0, 1, 0);
				rotation = 180;
				signature = signature;
			});
			CenterIcon = Roact.createElement(Icon, {
				signature = signature;
				position = UDim2.new(0.5, 0, 0.5, 0);
				size = CONFIG.Interface.Signature.CenterIconSize;
			});
			TopSignature = Roact.createElement(Signature, {
				signature = signature;
			});
		}
	elseif direction == Enums.CardDirection.Down then
		additionalProps = {
			BackgroundColor3 = CONFIG.Interface.CardBackColor;
		}
		additionalChildren = {}
	end

	local strokeColor = Color3.new(0, 0, 0)
	if selected then
		strokeColor = Color3.new(1, 0.9, 0)
	end

	local cardElement = Roact.createElement("Frame",
		Llama.Dictionary.join(
			{
				AnchorPoint = anchorPoint;
				Position = self.position or position;
				Rotation = self.rotation or rotation;
				Size = CONFIG.Interface.CardSize;
				ZIndex = zIndex;
				[Roact.Ref] = self.instance;
			},
			additionalProps
		),
		Llama.Dictionary.join(
			{
				Corner = Roact.createElement("UICorner");
				-- WHYYYY DONT UISTROKES WORK ON TEXTBUTTONS
				InputCapture = Roact.createElement("TextButton", {
					BackgroundTransparency = 1;
					Size = UDim2.new(1, 0, 1, 0);
					Text = "";
					[Roact.Event.Activated] = onClick;
				});
				Stroke = Roact.createElement("UIStroke", {
					Color = strokeColor;
				});
			},
			additionalChildren
		)
	)

	if needsAnimation then
		return Roact.createFragment({
			consumer = Roact.createElement(TableContext.Consumer, {
				render = function(context)
					return Roact.createElement(Roact.Portal, {
						target = context.surfaceGuiRef:getValue();
					}, {
						Card = cardElement;
					})
				end;
			});
			target = Roact.createElement("Frame", {
				BackgroundTransparency = 1;
				Position = position;
				Rotation = rotation;
				Size = UDim2.new(0, 0, 0, 0);
				[Roact.Ref] = self.targetInstance;
			})
		})
	else
		return cardElement
	end
end

function Card:didMount()
	-- wait for UI layouts to move cards
	task.defer(function()
		local targetInstance = self.targetInstance:getValue()
		if targetInstance then
			self.motor:setGoal({
				rotation = Flipper.Spring.new(targetInstance.Rotation);
				X = Flipper.Spring.new(targetInstance.AbsolutePosition.X);
				Y = Flipper.Spring.new(targetInstance.AbsolutePosition.Y);
			})
		end
	end)
end

function Card:didUpdate()
	task.defer(function()
		local props = self.props
		local playerId = props.playerId
		local signature = props.signature
		local instance = self.instance:getValue()
		if instance then
			CardPositionCache:set(signature, playerId, {
				position = instance.AbsolutePosition;
				rotation = instance.Rotation;
			})
		end
	end)
end

return Card