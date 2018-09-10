![alt text][logo]
# Extended dual-task paradigm

###### Julian Matthews, Pia Schröder, Lisandro Kaunitz, Jeroen van Boxtel, Naotsugu Tsuchiya

***

[**The paper that implements this code has been accepted for publication in Philosophical Transactions B. It is available here.**](http://rstb.royalsocietypublishing.org/content/373/1755/20170352)

> Whether conscious perception requires attention remains a topic of intense debate. While certain complex stimuli such as faces and animals can be discriminated outside the focus of spatial attention, many simpler stimuli cannot. Because such evidence was obtained in *dual-task paradigms* involving no measure of subjective insight, it remains unclear whether accurate discrimination of unattended complex stimuli is the product of automatic, unconscious processing, as in blindsight, or is accessible to consciousness. Furthermore, these paradigms typically require extensive training over many hours, bringing into question whether this phenomenon can be achieved in naive subjects. We developed a novel dual-task paradigm incorporating confidence ratings to calculate metacognition and adaptive staircase procedures to reduce training. With minimal training, subjects were able to discriminate face-gender in the near absence of top–down attentional amplification, while also displaying above-chance metacognitive accuracy. By contrast, the discrimination of simple coloured discs was significantly impaired and metacognitive accuracy dropped to chance-level, even in a partial-report condition. In a final experiment, we used blended face/disc stimuli and confirmed that face-gender but not colour orientation can be discriminated in the dual task. Our results show direct evidence for metacognitive conscious access in the near absence of attention for complex, but not simple, stimuli.

## What is this?
Here we provide MATLAB code for building psychophysics experiments that employ our [extended Dual-Task design](https://en.wikipedia.org/wiki/Dual-task_paradigm). 

## You will need: 
1. **MATLAB**
2. [**Psychtoolbox**](http://psychtoolbox.org/)
3. Monitor set to **60Hz display**

This experiment has been coded to present items at specific frames. Stimuli will appear *very quickly* if your monitor is set to a higher framerate. Check your display settings to confirm.

## Description:
The experiment included in this repository employs a dual-task design to examine the relationship between [attention and consciousness](https://www.researchgate.net/profile/Naotsugu_Tsuchiya/publication/309702790_Relationship_between_selective_visual_attention_and_visual_consciousness/links/58638e3f08aebf17d3973831.pdf). 

Our implementation of the dual-task design here draws many features from a 2004 study conducted by [Leila Reddy and colleagues](http://jov.arvojournals.org/article.aspx?articleid=2121636). Clone or download the repository to examine how it works. 

## Methods:
Included below is a figure that outlines different features of our dual-task design. [**SOA**](https://en.wikipedia.org/wiki/Stimulus_onset_asynchrony) is **Stimulus Onset Asynchrony**: the time between the start of one item and the start of the next. 

![alt_text][methods]

#### a) Peripheral stimuli and scrambled masks used in `runExp1.m`
Approximately 60 male and female faces in greyscale.

#### b) Peripheral stimuli and [Mondrian](http://www.piet-mondrian.org/paintings.jsp) masks used in `runExp2.m`
Red/green and green/red bisected disks.

#### c) Task procedure 
Experiment One is used as an example here. Single-task blocks involve responding to either the central or peripheral stimulus alone. Dual-task blocks require that subjects respond to both stimuli, starting with the central task. Subjects use one mouse click to record both their decision and confidence.

#### d) Task and report relevance
Note the **partial-report** dual-task requires that subjects make only one response per trial but to either the central or peripheral task. There is a 50% chance of either.

![alt_text][avatar]

[methods]: ../master/methods-figure-Dual-Task.png "Dual-Task methods for Matthews et al. (in prep)"

[logo]: https://raw.githubusercontent.com/julian-matthews/MoNoC-practice-experiment/master/MoNoC_minimal.png "Monash Neuroscience of Consciousness"

[avatar]: https://avatars0.githubusercontent.com/u/18410581?v=3&s=96 "I'm Julian"
