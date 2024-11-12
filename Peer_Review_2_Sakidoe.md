# Code Review for Programming Exercise 2 #
------------------------------------------
## Peer-reviewer Information

* *name:* Richard Huang
* *email:* ridhuang@ucdavis.edu

### Stage 1 ###
---
- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 

It does exactly what the position lock camera is supposed to do! The camera follows the movements of the vessel, and when you press [f] it creates a nice cross that centers on the vessel.

### Stage 2 ###
---
- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
I like this implementation. It was really nice to see a nice sized box that has the vessel locked within it, and when the vessel has no commands it follows the speed of the cameras movements.

### Stage 3 ###
---
- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
This stage relatively does what the instruction set requests. The vessel never moves away from the leash distance of the center of the camera, and the [f] key produces a nice cross. I would say like my own implementation, when the vessel stops moving, it retracts back to the camera, instead of the camera going to the vessel. I would gander it is [apart of this code](https://github.com/ensemble-ai/exercise-2-camera-control-ruohan8/blob/5385dafb20719816017f77408205d7d4bbaafd46/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L32-L36). Otherwise, it was amazing!

### Stage 4 ###
---
- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [x] Unsatisfactory

#### justification ##### 
This code looks to start well, but when I try to move, and the camera moves to what I presume to be the leash distance of the vessel, the program crashes with the error [Cannot call method 'is_stopped' on a previously freed instance]. I found that editing [This line](https://github.com/ensemble-ai/exercise-2-camera-control-ruohan8/blob/5385dafb20719816017f77408205d7d4bbaafd46/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L52) to [if _timer != null and _timer.is_stopped():] helped as the timer is free when the camera is moving but without that extra condition, your code does not account if it might be accessed later. and when freed, is_stopped() cannot be called on it. After changing that though, I could also see that after a few seconds of no moving, the camera shifts back to the vessel. The logic is good, just could not be ran.

### Stage 5 ###
---
- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The code for this is great, moving the camera when outside of the inner box a little, and when the vessel is at the edges, fully push the box as a pushboxCamera. I would say the only flaw would be making the camera move a little faster before it hits the edge, because I had to take a while to differentiate it from the normal pushbox camera. Without much movement, it doesn't feel a like a gradual increase in speed, but moreso a sudden acceleration.
 
### Code Style Review ###
---
#### Style Guide Infractions ####
1. I noticed that you didn't capitalize your comments, I'd recommend doing that for the next project!
2. some of your comments are very discriptive, and some are one word. Some places have heavy commenting and some have barely any! Though I could definitely understand what the comments indicate, a little more elaboration would not hurt! : )
3. Some comments have spacing between the [#] and the comment itself. [These two comments](https://github.com/ensemble-ai/exercise-2-camera-control-ruohan8/blob/5385dafb20719816017f77408205d7d4bbaafd46/Obscura/scripts/camera_controllers/auto_scroll.gd#L33-L34) for example are different from other file comments!
#### Style Guide Exemplars ####
1. I really liked your spacing between functions. It kept with the style guide, and also really makes it easy to read your code!

### Best Practices Review ###
---
#### Best Practices Infractions ####
1. I would say the naming for your variables in your speedup_pushbox camera is a little hard to read, but I was still able to read and determine what it was for!
#### Best Practices Exemplars ####
1. I really liked how you foldered your code all into a file for scripts. It made peer reviewing this really fast to navigate.
2. The variables were really nicely named. They are very descriptive to their purpose.
    

