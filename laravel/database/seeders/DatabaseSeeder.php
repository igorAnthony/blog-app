<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

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
        $category->image = 'http://192.168.1.6:8000/storage/categories/cyber_segurancao.jpeg';
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
        $category->image = 'http://192.168.1.6:8000/storage/categories/sustentabilidade_tech.jpg';
        $category->save();

        $category = new \App\Models\CategoryTech();
        $category->name = 'UX & UI Design';
        $category->description = 'Notícias sobre design de interface e experiência do usuário';
        $category->image = 'http://192.168.1.6:8000/storage/categories/jacare_debone.jpg';
        $category->save();

        $category = new \App\Models\CategoryTech();
        $category->name = 'Games';
        $category->description = 'Notícias sobre jogos';
        $category->image = 'http://192.168.1.6:8000/storage/categories/astronauta3.jpg';
        $category->save();

        $user = new \App\Models\User();

        $user->name = 'Admin';
        $user->email = 'admin@gmail.com';
        $user->password = bcrypt('1qa2ws');
        $user->username = 'admin_oliveira';
        $user->about_me = 'Sou um administrador';
        $user->speciality = 'Flutter Developer';
        $user->save();

        /*$table->id();
            $table->integer('user_id');
            $table->string('body');
            $table->string('title');
            $table->foreignId('category_tech_id')->nullable()->constrained('category_teches')->onDelete('cascade');
            $table->string('image')->nullable();
            $table->timestamps();
        });*/
        //create a post from admin with random data
        

    }
}
