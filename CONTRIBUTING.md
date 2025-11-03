# General 
In order to merge your work follow [GDScript styleguide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html). 


## Beginning work (for collaborators)
### 1. Clone repo:
```bash
git clone https://github.com/AntynK/GameOff2025Jam.git
```
If you have already done this, update it:
```bash
git checkout main
git pull origin main
```
### 2. Create new a branch with an understandable name:
```bash
git checkout -b <category>/<description>.
``` 
Branch categories:
* feature - new feature (new item, entity);
* fix - bug fix;
* refactor - improve code quality;

Examples:
* feature/add-heal-potion
* fix/player-stuck-in-wall
* refactor/player-collision-code

### 3. Add and commit your changes:
```bash
git add .
git commit -m "Description of changes"
```
### 4. Push your changes:
```bash
git push origin <your branch with descriptive name, from step 2>
```
After that, open GitHub and create a pull request with a descriptive name.