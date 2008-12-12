//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================




package no.makingwaves.cust.dss.code
{
	import no.makingwaves.cust.dss.model.ModelLocator;
	import mx.containers.Canvas;
	public class MainViewBase extends Canvas
	{
		// attributes ============================
		[Bindable]
		protected var model : ModelLocator = ModelLocator.getInstance();

	}
}