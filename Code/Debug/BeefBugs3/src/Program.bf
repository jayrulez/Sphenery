namespace BeefBugs3;

interface IOps{
	void Operation1();
}

interface ILogs{

}

class MyOpdeviceBase{

}

class MyOpDevice : MyOpdeviceBase, IOps, ILogs {

	public void Operation1()
	{

	}
}

class Program
{
	public static void Main(){
		var device = scope MyOpDevice();

		device.Operation1();
	}
}