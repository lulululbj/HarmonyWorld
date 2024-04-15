export class StringUtil {
  static isEmpty(str: string | undefined | null) {
    if (str == undefined || str == null) {
      return true
    }
    return str.length == 0
  }

  static isNotEmpty(str: string | undefined | null) {
    if (str == undefined || str == null) {
      return false
    }
    return str.length > 0
  }
}

