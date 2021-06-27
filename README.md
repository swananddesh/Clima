# Clima
An iOS app that will fetch weather condition info based on user's current location. Also user can enter city name to check weather conditions of desired city.
Open weather map API is used to fetch weather info.

## Pods used for this project:
1. Alamofire: For network request
2. SwiftyJSON: For handling api response.

**Below code is added in info.plist to handle http request, because open weather doesn't provide API with secured layer i.e. https. If we do not add this code in info.plist, then our app won't work because Apple do not give permission to call those APIs which are not secured.**



**Note:** After cloning/downloading Zip file of this project, create an account on **openweathermap.org** so that you can have an APP_ID which is essential to call API endpoint. Once you get an APP_ID, paste it as value to the variable in WeatherViewController.swift file

```
let APP_ID = "ENTER_APP_ID_HERE" // Create your account on openweather.org and then paste APP_ID here.
```



```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>openweathermap.org</key>
        <dict>
            <key>NSIncludesSubdomains</key>
            <true/>
            <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>

```

## Screenshot:

[![Simulator-Screen-Shot-i-Phone-8-2021-06-27-at-16-04-09.png](https://i.postimg.cc/W4h567Y7/Simulator-Screen-Shot-i-Phone-8-2021-06-27-at-16-04-09.png)](https://postimg.cc/4KRvXpgK)

[![Simulator-Screen-Shot-i-Phone-8-2021-06-27-at-16-20-24.png](https://i.postimg.cc/QdrmwTNp/Simulator-Screen-Shot-i-Phone-8-2021-06-27-at-16-20-24.png)](https://postimg.cc/D8B1bmXZ)
