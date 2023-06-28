using System;
namespace BeefBugs;

class Program
{
	public static void Main()
	{
		Event<delegate void(int)> ev = .();
		//Event<delegate void(int id)> ev = .(); // replacing the line above with this works around the bug

		void handler(int id){}

		delegate void(int id) handlerDelegate = scope => handler;

		ev.Add(handlerDelegate);

		ev.Remove(handlerDelegate);
	}
}