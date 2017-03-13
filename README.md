# MelbourneZoo
Melbourne Zoo implementation using POP

The Melbourne Zoo is trying to organize their data on some of the animals they need to re-home. They want to be able to store common traits and unique behaviour so they can better categorize and organize their animals.The approach that they would like to take is to have the certain animal class inherit their features in a flexible way, rather than in a set and structured way.

The first set of animals they need to do this for are:

| Name | Sex | Size | Class | Age | Weight (kg) | Diet |
| --- | --- | --- | --- | --- | --- | --- | 
| Polar Bear | Male | Large | Mammal | 20 | 450 | Carnivore |
| Lion | Female | Large | Mammal | 10 | 250 | Carnivore |
| Shark |	Female |	Large |	Fish | 5 | 1000 |	Carnivore |
| Eagle |	Male |	Medium |	Bird |	2 |	5 |	Carnivore |
| Tarantula |	Female |	Extra small |	Invertebrate |	1	| .5 |	Carnivore |
| Snake |	Female |	Small |	Reptile |	1	| .5 |	Carnivore |
| Elephant |	Male |	Extra Large |	Mammal |	15 |	5,400 |	Herbivore |
| Seal |	Male |	Medium |	Mammal |	3 |	75 |	Carnivore |
| Koala |	Female |	Medium |	Mammal |	2 |	15 |	Herbivore |


In order to re-introduce these animals to the wild, they need some key information that is shared amongst them all.

Sex (Female, Male, Other)
Size (Extra Small, Small, Medium, Large, Extra Large)
Age
Weight
They will also need to check the abilities certain animals have. Some of these may require different implementations even though they may be of the same type.

Swim
Any animals that can swim (fish, mammals, reptiles, birds) will have a swim speed
Fish should also have a characteristic adjustedSpeed: calculated by (swim speed/weight)/age
Enclosure Size
Only applicable to Mammals
function that returns size class value (extra small = 0 etc) * weight
Diet
If they are carnivore, they should have a function that returns how much meat they need to eat (size class value (extra small = 0 etc) * weight = food in grams)
This is not an exhaustive list and the Zoo would like to be able to apply a similar approach to all other animals in their care. So the structure and implementation of the data should be able to easily scale. They also want this to be able to work easily in the future, so please use Swift 3.0 in the swift style of coding.

You should use Structs, Enums, Protocols, Extensions, Classes, Overridden functions and Conformance where necessary. As they would like it to be easily re-useable, inheritance will be required. Bonus points for not using

After the above animal classes have been implemented, you should print out the following information:

Which animals will required a truck to be moved (Large size or above)?

Which animals can travel together (Carnivores separately, herbivores can travel together)?

Animals that require an enclosure ordered by size in ascending order?
