package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.IMEEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Multitouch;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextField;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;

	[SWF(width = "800", height = "600", frameRate = "30", backgroundColor = "0x000000")]
	
	public class Main extends MovieClip 
	{
		public var blocksArray:Array;
		
		public var rowSize:int = 2;
        public var colSize:int = 2;
		public var maxNum:int = 8;
		public var minNum:int = 2;
		
		public var item:Point;
		public var winState:Boolean = false;
		public var myFormat:TextFormat = new TextFormat;
		public var displayText:TextField = new TextField;
		public var displayHolder:Sprite = new Sprite();
		public var glow:GlowFilter;
		public var resetButton:Sprite = new Sprite();

		public function Main() 
		{
			init();
		}
		
		public function init():void
		{
			resetButton.graphics.lineStyle(1, 0xFF0000);
			resetButton.graphics.beginFill(0, 0x000000);
			resetButton.graphics.drawRect(0, 0, 200, 50);
			resetButton.x = 550;
			resetButton.y = 50;
			resetButton.addEventListener(MouseEvent.CLICK, resetGame);
			
			glow = new GlowFilter();
			glow.color = 0xFF0000;
			glow.alpha = 1;
			glow.blurX = 18;
			glow.blurY = 18;
			glow.quality = BitmapFilterQuality.HIGH;
			resetButton.filters = [glow];
			
			myFormat.size = 25;
			myFormat.align = TextFormatAlign.CENTER;
			displayText = new TextField();
			displayText.defaultTextFormat = myFormat;
			displayText.textColor = 0xFF0000;
			displayText.width = 200;
			displayText.y = 10;
			displayText.mouseEnabled = true;
			displayText.text = "Reset Grid!";
			resetButton.addChild(displayText);
			
			addChild(resetButton);
			
			rowSize = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			colSize = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			
			fillBlockArray();
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function resetGame(e:MouseEvent):void
		{			
			stage.removeEventListener(Event.ENTER_FRAME, update);
			
			for (var i:int = 0; i < rowSize; i++)
			{
				for (var j:int = 0; j < colSize; j++)
				{
					removeChild(blocksArray[i][j]);
				}
			}
			
			rowSize = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			colSize = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			
			fillBlockArray();
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function startGame(e:MouseEvent):void
		{	
			stage.removeEventListener(MouseEvent.CLICK, startGame);
			
			rowSize = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			colSize = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			
			removeChild(displayHolder);
			
			fillBlockArray();
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			winState = true;
			checkWin();
		}
		
		public function checkWin():void
		{
			for (var i:int = 0; i < rowSize; i++)
			{
				for (var j:int = 0; j < colSize; j++)
				{
					if (blocksArray[i][j].getClickState() == true)
						winState = false;
				}
			}
			
			if (winState)
				winGame();
		}
		
		public function winGame():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, update);
			
			for (var i:int = 0; i < rowSize; i++)
			{
				for (var j:int = 0; j < colSize; j++)
				{
					removeChild(blocksArray[i][j]);
				}
			}
			
			myFormat.size = 25;
			myFormat.align = TextFormatAlign.CENTER;
			displayText = new TextField();
			displayText.defaultTextFormat = myFormat;
			displayText.textColor = 0xFF0000;
			displayText.background = true; 
			displayText.backgroundColor = 0xC0C0C0;
			displayText.width = 200;
			displayText.height = 35;
			displayText.x = 300;
			displayText.y = 10;
			displayText.text = "You Win!";
			displayHolder.addChild(displayText);
			
			displayText = new TextField();
			displayText.defaultTextFormat = myFormat;
			displayText.textColor = 0xFF0000;
			displayText.background = true; 
			displayText.backgroundColor = 0xC0C0C0;
			displayText.width = 250;
			displayText.height = 35;
			displayText.x = 300;
			displayText.y = 560;
			displayText.text = "Click To Play Again!";
			displayHolder.addChild(displayText);
			
			addChild(displayHolder);
			
			stage.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		public function fillBlockArray():void
		{
			blocksArray = new Array();
			
			for (var n:int = 0; n < rowSize; n++)
			{
				blocksArray.push(new Array(colSize));
			}
			
			for (var i:int = 0; i < rowSize; i++)
			{
				for (var j:int = 0; j < colSize; j++)
				{
					blocksArray[i][j] = new Block();
					
					blocksArray[i][j].x = i * blocksArray[i][j].width;
					blocksArray[i][j].y = j * blocksArray[i][j].height;
					blocksArray[i][j].addEventListener(MouseEvent.CLICK, checkClick);
					blocksArray[i][j].addEventListener(MouseEvent.MOUSE_OVER, checkMouseOver);
					blocksArray[i][j].addEventListener(MouseEvent.MOUSE_OUT, checkMouseOut);
					blocksArray[i][j].setXPos(i);
					blocksArray[i][j].setYPos(j);
					blocksArray[i][j].setClickState(true);
					addChild(blocksArray[i][j]);
				}
			}			
		}
		
		public function checkClick(me:MouseEvent):void
		{			
			toggleSquare(me.currentTarget as Block);
			
			var gridX:int = getXPos(me.currentTarget as Block);
			var gridY:int = getYPos(me.currentTarget as Block);
			
			toggleSquare(blocksArray[gridX][gridY - 1]);
			toggleSquare(blocksArray[gridX][gridY + 1]);
			
			if (gridX > 0)
				toggleSquare(blocksArray[gridX - 1][gridY]);
			
			if (gridX < rowSize - 1)
				toggleSquare(blocksArray[gridX + 1][gridY]);
		}
		
		public function checkMouseOver(me:MouseEvent):void
		{
			var gridX:int = getXPos(me.currentTarget as Block);
			var gridY:int = getYPos(me.currentTarget as Block);
			
			blocksArray[gridX][gridY].setMouseOver(true);
		}
		
		public function checkMouseOut(me:MouseEvent):void
		{
			var gridX:int = getXPos(me.currentTarget as Block);
			var gridY:int = getYPos(me.currentTarget as Block);
			
			blocksArray[gridX][gridY].setMouseOver(false);
		}
		
		public function toggleSquare(block:Block):void
		{
			if (!block)
				return;
			
			if (block.getClickState() == true)
				block.setClickState(false);
			else if (block.getClickState() == false)
				block.setClickState(true);
		}
		
		public function getXPos(block:Block):int
		{
			if (!block)
				return 0;
			else
				return(block.getXPos());
		}
		
		public function getYPos(block:Block):int
		{
			if (!block)
				return 0;
			else
				return(block.getYPos());
		}
	}
}