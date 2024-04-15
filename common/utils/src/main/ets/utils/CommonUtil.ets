export function sleep(interval: number) {
  return new Promise<number>(resolve => {
    setTimeout(resolve, interval)
  })
}