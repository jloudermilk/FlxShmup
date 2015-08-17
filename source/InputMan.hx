package;

class InputMan {
	private static var instance:InputMan;
	public 
	public static inline function getInstance()
	{
		if(instance == null)
			return instance = new InputMan;
		else 
			return instance;
	}
}