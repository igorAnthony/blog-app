<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $category = new \App\Models\CategoryTech();
        $category->name = 'Tec Notícias';
        $category->description = 'Notícias sobre tecnologia';
        $category->image = 'http://192.168.1.6:8000/storage/categories/noticia_tec.jpeg';
        $category->save();

        $category = new \App\Models\CategoryTech();
        $category->name = 'Dev Software';
        $category->description = 'Notícias sobre desenvolvimento de software';
        $category->image = 'http://192.168.1.6:8000/storage/categories/alan_turing.jpeg';
        $category->save();

        $category = new \App\Models\CategoryTech();
        $category->name = 'IA & VR';
        $category->description = 'Notícias sobre inteligência artificial e realidade virtual';
        $category->image = 'http://192.168.1.6:8000/storage/categories/cyber_seguranca.jpeg';
        $category->save();

        $category = new \App\Models\CategoryTech();
        $category->name = 'Apps & Tools';
        $category->description = 'Notícias sobre aplicativos e ferramentas';
        $category->image = 'http://192.168.1.6:8000/storage/categories/robotech.jpg';
        $category->save();

        $category = new \App\Models\CategoryTech();
        $category->name = 'Eventos Tech';
        $category->description = 'Notícias sobre eventos de tecnologia';
        $category->image = 'http://192.168.1.6:8000/storage/categories/evento.jpg';
        $category->save();
        
        $category = new \App\Models\CategoryTech();
        $category->name = 'Sustent. Tech';
        $category->description = 'Notícias sobre sustentabilidade relacionada a tecnologia';
        $category->image = 'http://192.168.1.6:8000/storage/categories/sustentabilidade_tech.jpeg';
        $category->save();

        $category = new \App\Models\CategoryTech();
        $category->name = 'UX & UI Design';
        $category->description = 'Notícias sobre design de interface e experiência do usuário';
        $category->image = 'http://192.168.1.6:8000/storage/categories/jacare_debone.jpg';
        $category->save();

        $category = new \App\Models\CategoryTech();
        $category->name = 'Games';
        $category->description = 'Notícias sobre jogos';
        $category->image = 'http://192.168.1.6:8000/storage/categories/astronauta3.jpeg';
        $category->save();

        
        $user = new \App\Models\User();
        $user->name = 'Admin';
        $user->email = 'admin@gmail.com';
        $user->password = bcrypt('1qa2ws');
        $user->username = 'admin_oliveira';
        $user->about_me = 'Sou um administrador';
        $user->speciality = 'Flutter Developer';
        $user->avatar = 'https://picsum.photos/200/300?random=$1';
        $user->save();
        
        $faker = Faker::create();

        for ($i = 0; $i < 10; $i++) {
            $newUser = new \App\Models\User();
            $newUser->name = $faker->name;
            $newUser->email = $faker->email;
            $newUser->password = bcrypt('1qa2ws');
            $newUser->username = $faker->userName;
            $newUser->about_me = $faker->sentence;
            $newUser->speciality = $faker->jobTitle;
            $newUser->avatar = 'https://picsum.photos/200/300?random='. $i + 2;
            $newUser->save();
                
            $newFollow = new \App\Models\Follow();
            $newFollow->follower_id = $newUser->id;
            $newFollow->following_id = $user->id;
            $newFollow->save();
        
            $newFollow2 = new \App\Models\Follow();
            $newFollow2->follower_id = $user->id;
            $newFollow2->following_id = $newUser->id;
            $newFollow2->save();
        }
        
        $user->save();



        $story = new \App\Models\Story();
        $story->user_id = 1;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo1.jpeg';
        $story->save();


        $story = new \App\Models\Story();
        $story->user_id = 1;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo2.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 2;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo3.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 3;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo3.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 4;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo4.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 5;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo5.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 6;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo6.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 7;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo7.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 7;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo8.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 1;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo9.jpeg';
        $story->save();

        $story = new \App\Models\Story();
        $story->user_id = 7;
        $story->image = 'http://192.168.1.6:8000/storage/stories/photo10.jpeg';
        $story->save();
        

    }
}
