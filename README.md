# Telegram Clone Task
This is an assessment task given by "Automative by Napa."

I have implemented this project on the [**Texture**](https://texturegroup.org) framework (originally built by Facebook devs). Telegram used this framework to build UI. Texture's basic unit is the node. Nodes are thread-safe. It helps to instantiate and configure entire hierarchies in parallel on background threads. I built Calls and AccountDetails (AD) pages on this framework, as it's noted on the task.

### SSignalKit
SSignalKit is developed by Telegram developers.

### TelegramNetwork
I separated the network part from the main project. This module consists of all data related to the Network side of the app and added unit tests to test network services. All tests are implemented on the [XCTTest](https://developer.apple.com/documentation/xctest) framework.  
