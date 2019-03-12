# SwifterRateVC
Easy to use iOS app store rate controller

## Usage
Requires [Swifter](https://github.com/rokgregoric/Swifter).

```
RateVC.showCounter = 3
RateVC.decrementCounter()
if !RateVC.shouldShow { return }
segue(to: RateVC.self)
```