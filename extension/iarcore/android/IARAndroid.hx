package extension.iarcore.android;

#if android
import extension.iarcore.android.util.JNICache;
import lime.app.Event;

/**
 * A class for managing in-app reviews on Android using Google Play's In-App Review API.
 */
class IARAndroid
{
	/** Event for logging debug messages. */
	public static final onLog:Event<String->Void> = new Event<String->Void>();

	/** Event triggered when a review flow completes. */
	public static final onReviewCompleted:Event<Bool->Void> = new Event<Bool->Void>();

	/** Event triggered when a review flow fails. */
	public static final onReviewError:Event<String->Void> = new Event<String->Void>();

	/**
	 * Initializes the review managers.
	 */
	public static function init():Void
	{
		final initJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/IARCore', 'init', '(Lorg/haxe/lime/HaxeObject;)V');

		if (initJNI != null)
			initJNI(new IARAndroidCallbackObject());
	}

	/**
	 * Requests and launches the review flow.
	 */
	public static function requestAndLaunchReviewFlow():Void
	{
		final requestAndLaunchReviewFlowJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/IARCore','requestAndLaunchReviewFlow', '()V');

		if (requestAndLaunchReviewFlowJNI != null)
			requestAndLaunchReviewFlowJNI();
	}

	/**
	 * Requests and launches the fake review flow.
	 */
	public static function requestAndLaunchFakeReviewFlow():Void
	{
		final requestAndLaunchFakeReviewFlowJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/IARCore', 'requestAndLaunchFakeReviewFlow', '()V');

		if (requestAndLaunchFakeReviewFlowJNI != null)
			requestAndLaunchFakeReviewFlowJNI();
	}
}

@:noCompletion
private class IARAndroidCallbackObject #if (lime >= "8.0.0") implements lime.system.JNI.JNISafety #end
{
	public function new():Void {}

	@:keep
	#if (lime >= "8.0.0")
	@:runOnMainThread
	#end
	public function onLog(message:String):Void
	{
		if (IARAndroid.onLog != null)
			IARAndroid.onLog.dispatch(message);
	}

	@:keep
	#if (lime >= "8.0.0")
	@:runOnMainThread
	#end
	public function onReviewCompleted(success:Bool):Void
	{
		if (IARAndroid.onReviewCompleted != null)
			IARAndroid.onReviewCompleted.dispatch(success);
	}

	@:keep
	#if (lime >= "8.0.0")
	@:runOnMainThread
	#end
	public function onReviewError(error:String):Void
	{
		if (IARAndroid.onReviewError != null)
			IARAndroid.onReviewError.dispatch(error);
	}
}
#end
