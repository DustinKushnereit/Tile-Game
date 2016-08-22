package 
{
	import flash.display.*;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;

	public class Block extends Sprite
	{		
		public var clickState:Boolean = false;
		public var xPos:int;
		public var yPos:int;
		public var glow:GlowFilter;
		public var mouseOver:Boolean = false;

		public function Block()
		{
			drawBlock();
		}

		private function drawBlock():void
		{
			graphics.lineStyle(1, 0xFF0000);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(50, 50, 50, 50);
		}
		
		public function setClickState(newClickState:Boolean):void
		{
			this.clickState = newClickState;
			updateClickState();
		}
		
		public function getClickState():Boolean
		{
			return(this.clickState);
		}
		
		public function setYPos(newPos:int):void
		{
			yPos = newPos;
		}
		
		public function getYPos():int
		{
			return(this.yPos);
		}
		
		public function setXPos(newPos:int):void
		{
			xPos = newPos;
		}
		
		public function getXPos():int
		{
			return(this.xPos);
		}
		
		public function setMouseOver(newMouseOver:Boolean):void
		{
			mouseOver = newMouseOver;
			updateClickState();
		}

		private function updateClickState():void
		{
			switch(clickState)
			{
				case true:
					if (this.mouseOver == true)
					{
						graphics.clear();
						graphics.lineStyle(1, 0x0080FF);
						graphics.beginFill(0xFFFF00);
						graphics.drawRect(50, 50, 50, 50);
						
						glow = new GlowFilter();
						glow.color = 0x0080FF;
						glow.alpha = 2;
						glow.blurX = 18;
						glow.blurY = 18;
						glow.quality = BitmapFilterQuality.HIGH;
						this.filters = [glow];
					}
					else
					{
						graphics.clear();
						graphics.lineStyle(1, 0xFF0000);
						graphics.beginFill(0xFFFF00);
						graphics.drawRect(50, 50, 50, 50);
						
						glow = new GlowFilter();
						glow.color = 0xFFFF00;
						glow.alpha = 1;
						glow.blurX = 18;
						glow.blurY = 18;
						glow.quality = BitmapFilterQuality.HIGH;
						this.filters = [glow];
					}
				break;
				
				case false:
					if (this.mouseOver == true)
					{
						graphics.clear();
						graphics.lineStyle(1, 0x0080FF);
						graphics.beginFill(0x000000);
						graphics.drawRect(50, 50, 50, 50);
						
						glow = new GlowFilter();
						glow.color = 0x0080FF;
						glow.alpha = 2;
						glow.blurX = 18;
						glow.blurY = 18;
						glow.quality = BitmapFilterQuality.HIGH;
						this.filters = [glow];
					}
					else
					{
						graphics.clear();
						graphics.lineStyle(1, 0xFF0000);
						graphics.beginFill(0x000000);
						graphics.drawRect(50, 50, 50, 50);
						
						glow = new GlowFilter();
						glow.color = 0x000000;
						glow.alpha = 0;
						glow.blurX = 18;
						glow.blurY = 18;
						glow.quality = BitmapFilterQuality.HIGH;
						this.filters = [glow];
					}
				break;
			}
		}
		
		private function updateMouseOver():void
		{
			switch(mouseOver)
			{
				case true:
				graphics.clear();
				graphics.lineStyle(1, 0x0080FF);
				graphics.drawRect(50, 50, 50, 50);
				
				glow = new GlowFilter();
				glow.color = 0x0080FF;
				glow.alpha = 1;
				glow.blurX = 18;
				glow.blurY = 18;
				glow.quality = BitmapFilterQuality.HIGH;
				this.filters = [glow];
				break;
				
				case false:
				break;
			}
		}
	}
}


