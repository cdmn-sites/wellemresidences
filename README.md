# The Wellem Residences

https://thewellemresidences.com

## Stack

 - [Ruby on Rails](https://www.rubyonrails.org)
 - [Svelte](https://svelte.dev)
 - [Inertia](https://inertiajs.com)
 - [SpinaCMS](https://spinacms.com)
 
## Developing

After cloning, run `rails spina:first_deploy` to set up Spina locally. Then run `rails c` and change the domain of your local Spina account to `localhost` (`Spina::Account.update_all domain: 'localhost'`). Then you should be able to access `/admin` and create your first Spina page.