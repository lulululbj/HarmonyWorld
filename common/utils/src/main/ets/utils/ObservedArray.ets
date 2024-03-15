/**
 * Description: 可观测数组
 * Author: luyao
 * Date: 2024/3/14 15:43
 */

@Observed
export class ObservedArray<T> extends Array<T> {
  constructor(args?: T[]) {
    if (args instanceof Array) {
      super(...args);
    } else {
      super();
    }
  }
}