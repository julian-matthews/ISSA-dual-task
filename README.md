![alt text][logo]
# Dual-Task
**ISSA2017 Psychophysics Hands-on Project**
## Coordinators
1. Nao Tsuchiya (Monash University)
2. Julian Matthews (Monash University)
3. Katsunori Miyahara (Rikkyo University)
4. Elizaveta Solomonova (University of Montreal)

### [The paper that implements this code is currently under review, please read our preprint here](https://psyarxiv.com/ef45x/)

## Outline
The aim of this hands-on project is to introduce two exemplar visual psychophysics paradigms. By experiencing what psychophysics tasks are like, students will be able to design their own experiment. Also, students will learn some basic analysis concepts: objective performance and [metacognitive sensitivity](http://journal.frontiersin.org/article/10.3389/fnhum.2014.00443/full), each based on [signal detection theory](http://psycnet.apa.org/psycinfo/2004-19022-000). A broader aim is to consider what these behavioural techniques might tell us about consciousness and related processes (such as attention, memory and metacognition). 

Here we provide MATLAB code for building psychophysics experiments that employ a [**Dual-Task** design](https://en.wikipedia.org/wiki/Dual-task_paradigm). Students are encouraged to modify this code to examine their own research questions in collaboration with the coordinators.

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
