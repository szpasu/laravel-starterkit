<h1 align="center" id="title">Laravel StarterKit</h1>

<p align="center"><img src="https://socialify.git.ci/szpasu/laravel-starterkit/image?description=1&amp;font=Source%20Code%20Pro&amp;forks=1&amp;issues=1&amp;language=1&amp;name=1&amp;owner=1&amp;pattern=Circuit%20Board&amp;stargazers=1&amp;theme=Dark" alt="project-image"></p>

<p id="description">A ready project with laravel and basic packages and a configured docker is the perfect solution for a new project.</p>

<h2>🧐 Installed Packages</h2>

Here're some of the packages installed:

- PHP 8.1
- Laravel 10.0 - https://github.com/laravel/laravel
- Laravel Cashier 14.0 - https://github.com/laravel/cashier-stripe
- Laravel Jetstream 2.11 - https://github.com/laravel/jetstream
- Laravel Sanctum 3.0 - https://github.com/laravel/sanctum
- Laravel Scout 9.4 - https://github.com/laravel/scout
- Laravel Socialite 5.5 - https://github.com/laravel/socialite
- Laravel Backup 8.1 - https://github.com/spatie/laravel-backup
- Laravel Permission 5.5 - https://github.com/spatie/laravel-permission
- Laravel Horizon 5.10 - https://github.com/laravel/horizon
- Laravel Telescope 4.9 - https://github.com/laravel/telescope
- Laravel Pint 1.1 - https://github.com/laravel/pint
- Laravel Dusk 7.0 - https://github.com/laravel/dusk
- Tailwind CSS 3.1 - https://github.com/tailwindlabs/tailwindcss
- Vie 3.0 - https://github.com/vitejs/vite

<h2>🛠️ Installation Steps:</h2>

<p>1. Copy .env.example to .env</p>

```
cp .env.example .env
```

<p>2. Setup properly project name</p>

```
APP_NAME=
```

<p>3. Run command of initialize</p>

```
make initialize
```

<h2>🛠️ Helpfully commands:</h2>

<p>Login into docker bash to execute commands</p>

```
make attach-workspace
```

<p>Run pint and dusk tests</p>

```
make test
```

<p>Run only pint tests</p>

```
make pint
```

<p>Run only dusk tests</p>

```
make dusk
```
