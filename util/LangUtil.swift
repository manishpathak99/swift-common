import Foundation


public final class LangUtil {
	public static func getString (byKey k: String) -> String {
		return NSLocalizedString(k, comment: "")
	}
}