#!/usr/bin/env python3
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )


#step: list the species seperately.

for Bird in birds:                  #use for loop to seperately list each attribute of birds
    print('latin:',Bird[0])         #print latin name of birds
    print('common:',Bird[1])        #peint common name of birds
    print('masses:',str(Bird[2]))   #print masses of birds

