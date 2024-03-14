import data_preferences from '@ohos.data.preferences'
import Log from './Log'

/**
 * Description: 键值对存储
 * Author: luyao
 * Date: 2024/3/14 15:28
 */

export class PreferenceUtil {
  private preferences: data_preferences.Preferences | null = null

  init(context: Context, preferenceName: string) {
    try {
      this.preferences = data_preferences.getPreferencesSync(context, { name: preferenceName })
    } catch (err) {
      Log.error("Failed to get preferences. code =" + err.code + ", message =" + err.message)
    }
  }

  getBoolean(key: string, defaultValue: boolean): boolean {
    return this.getSync(key, defaultValue) as boolean
  }

  getNumber(key: string, defaultValue: number): number {
    return this.getSync(key, defaultValue) as number
  }

  getString(key: string, defaultValue: string): string {
    return this.getSync(key, defaultValue) as string
  }

  getSync(key: string, defaultValue: data_preferences.ValueType): data_preferences.ValueType {
    if (this.preferences == null) {
      return defaultValue
    } else {
      return this.preferences.getSync(key, defaultValue)
    }
  }

  putSync(key: string, value: data_preferences.ValueType) {
    if (this.preferences != null) {
      this.preferences.putSync(key, value)
      this.preferences.flush()
    }
  }
}

export default new PreferenceUtil()
