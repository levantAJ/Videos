# Videos

### How to build:
1. Turn on your terminal, go to the project folder
2. Run `pod install`
3. Double click on `VideosAssignment.xcworkspace` to open project

### Summary:
1. Create a screen to contain an `UITableView` to show list videos 
	- User can play all videos at the same time, it mean play them as concurrent
	- In `playAllButtonTapped` method we can change animations to present videos
2. Create a play all button at bottom of screen to play all videos as serial

### Processing:
1. In List of videos screen: I created a custom `UITableViewCell` named: `VideoTableViewCell`
Inside the `VideoTableViewCell` I used one `VIMVideoPlayerView` to present a video

2. In the screen play all videos: I create two `VIMVideoPlayerView` to present the current video and the next video.

##### Why is only 2 views, not 1 or 3 or more than?**: 

If with 1 we can not add animation when next to another video. And we cannot use lazy loading the video before using, e.g. I loaded the second video to the second view when the fisrt view is playing

If you create 3 or more than, it will be inscrease your device's memories, this really not good. Just 2 views, we can re-use, try to keep memories as low as possible

##### Why `VIMVideoPlayerView` not `MPMoviePlayerController`

As you know, if we using `MPMoviePlayerController` we play **only one video** at a time, so that impossible in the project because: When we need to customise the animations or for our features it will make flicker (black flicker)

### Animations:
I create a simple animation: `VideoPlayerAnimation`.

With this animation we can `slide to left/right/top/bottom`, `fade` or `none`

#### Custom animations between videos:
##### Multiple animations type in a list video:
I think we should add new anchors between video cells in list videos screen (the first screen), when users tap on those anchors they can change the animations

##### Only one animation type in a list video:
I think we should add new button in Video playing screen (the second screen) as `Change animations`, beside cancel button, when users tap on the button, we show an action sheet to let users choose the animation which they want 

### Project Structure:
- ViewModule: Every module contains View, ViewModel & anything relates for front end.
  - Component: is view what they will be share between multiple screen
  - View: Represent for a screen
- Resource: Can contains Images, Sounds, Layout config file, etc.
- Storyboard: Put all storyboards at here.
- Engine: Shared class, enum, structure, or logic, business on backend, network, parser, helper, cache, data store, etc.