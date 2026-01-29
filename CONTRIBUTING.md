# General 
To merge your work, follow [GDScript style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html).

We are using a simplified Git flow strategy for our project. 
Our rules:
1. The `main` branch should not be used, it only contains releases.
2. If you want to add features, make your own branch from the `develop` branch. Also make PR to the `develop` branch. 
3. The develop branch should contain a stable version (runs without crash). 

## Workflow for contributors
### 1. Clone repo:
```bash
git clone https://github.com/AntynK/Cannon-and-Commerce.git
```
If you have already done this, update it:
```bash
git checkout develop
git pull origin develop
```

### 2. Create a new branch with an understandable name:
```bash
git checkout -b <category>/<description>
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
> [!IMPORTANT]
> Before pushing it is better to pull any changes: `git pull origin develop`

> [!IMPORTANT]
> Ensure the game runs before making PR!

```bash
git push origin <your branch with descriptive name, from step 2>
```

After that, open GitHub and create a pull request and provide a detailed description.
> [!IMPORTANT]
> Make a pull request to the `develop` branch.


## Workflow for collaborators
### 1. Update `develop` branch:
```bash
git checkout develop
git pull origin develop
```

### 2. Create a new branch with an understandable name:
```bash
git checkout -b <category>/<description>
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

### 4. Merge your changes locally:
```bash
git checkout develop
git pull origin develop
git merge <your branch name from step 2>
```

### 5. Push updated `develop`
> [!IMPORTANT]
> Before pushing it is better to pull any changes: `git pull origin develop`

> [!IMPORTANT]
> Ensure the game runs before pushing!

```bash
git push origin develop
```

### 6. Cleanup local branch:
```bash
git branch -d <your branch name from step 2>
```