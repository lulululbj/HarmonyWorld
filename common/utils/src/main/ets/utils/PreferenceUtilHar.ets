import data_preferences from '@ohos.data.preferences'
import Log from '../../../../../utils/src/main/ets/utils/Log'
import { Context } from '@kit.AbilityKit'
import { ValueType } from '@kit.ArkData'

/**
 * Description: 键值对存储
 * Author: luyao
 * Date: 2024/3/14 15:28
 */

export class PreferenceUtilHar {
  private preferences?: data_preferences.Preferences
  private static instance: PreferenceUtilHar
  private preferenceName = "HarmonyWorld"

  private constructor() {
  }

  public static getInstance(): PreferenceUtilHar {
    if (!PreferenceUtilHar.instance) {
      PreferenceUtilHar.instance = new PreferenceUtilHar()
    }
    return PreferenceUtilHar.instance
  }

  init(context: Context, preferenceName: string) {
    try {
      this.preferences = data_preferences.getPreferencesSync(context, { name: preferenceName })
    } catch (err) {
      Log.error("Failed to get preferences. code =" + err.code + ", message =" + err.message)
    }
  }

  setValue<T>(key: string, defaultValue: T) {
    if (this.preferences) {
      this.preferences.put(key, JSON.stringify(defaultValue))
      this.preferences.flush()
    }
  }

  getValue<T>(key: string, defaultValue: ValueType): T {
    try {
      if (this.preferences) {
        return this.preferences.getSync(key, defaultValue) as T
      }
      return defaultValue as T
    } catch (e) {
      Log.error(this.preferenceName, `getValue[${key}] error: ${e}`)
      return defaultValue as T
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