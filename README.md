# Planta Care
> Um sistema e uma aplicação para rega e monitoramento automático remotos de plantas

Esse projeto surgiu como proposta de um trabalho final em grupo na disciplina de Redes sem Fios ministrada pela professora [Analúcia Schiaffino Morales](https://buscatextual.cnpq.br/buscatextual/visualizacv.do?id=K4796320U7&tokenCaptchar=03ANYolqvSfjUV0Kq0XnMfyBhMtlqD-m8DQ0HLo3xWkELURbNIZsKldbbw2ym3FeA41rt1fbW8QUsFSGhsINLk2HmbiQ25i3U-06ZC6nN8rUztPDUHM6MwPMbQVIQoLZTbderb6Gy_zXMjxpGnOlodRklNn37BxV3sBWw3HXiUlYhGqRfic_KLS8WLrL33iZ8XKwIUqhCrTF8DLFFSlPBSuvN16A8cp2WrBiUxsw5r7voM_wwK-mg2skSnujnNB03cGFwgitcYSzuQwAPVAWS5IOk5sAxCWxNIBKVOeV0eeMp0pUzwVqLSglzDZFx69_mCYo2KNlyoP4q75x-fomATga5gKMQyGMG1bH448splC-jmKdjA7s3goCqnuzCu6-0m42ZQAobDMmFkV84ygrb3Q35buqUfaVrqUYSQ-hXLCrlqJlpaqQPamxlS3BPZcTU8iFJyKmnZoew-YhqyjZOdtMmXcGyhqZ1h9qfjHWE35_dbneC6JDbr6SdY0LoS4DIx0XY-3Anfqf4tsAk-VRsnffwC7Fe2X75hqCDQeuJJR9MP3Fm6gLq10ovcrPX4a__IamVgUyrul6NQx0tQQ_N4CC2kcMX2eNpkwA) da Universidade Federal de Santa Catarina  ([UFSC](https://ufsc.br/)). O relatório final do projeto se encontra [aqui](https://github.com/RaphaelRat/Planta-Care).

🚀 A equipe: 
- [Bruno Antonelli](https://github.com/brunoantonelli)
- [Leomar Marcelo Marschalk](https://github.com/LeomarMM)
- [Matheus Amboni](https://github.com/MatheusAmboni)
- [Raphael Abreu](https://github.com/RaphaelRat)
- [Yan Bentes](https://github.com/yanbentes)

A ideia do projeto é de um sistema de irrigação e  monitoração de plantas que pode ser controlado remotamente por um aplicativo mobile ([repositório](https://github.com/RaphaelRat/Planta-Care/tree/main/software/aplicacao)), através do envio e leitura de dados para a plataforma móvel Firebase, utilizando um ESP32 conectado à uma rede Wi-Fi  ([repositório](https://github.com/RaphaelRat/Planta-Care/tree/main/hardware)). 

Para isso foram utilizados sensores de umidade (tanto de solo quanto ambiente), um sensor de temperatura e um servo-motor (para regar a planta).

Para que o projeto se tornasse open-source, foi preciso remover o conteúdo sensível do mesmo e com isso é necessário configurá-lo antes de usar. Começando pelo [Firebase](https://firebase.google.com/), onde será necessário criar um projeto, e então pegar a API key e o endereço do RTDB (real-time databse) e definí-los nos arquivos do [hardware](https://github.com/RaphaelRat/Planta-Care/tree/main/hardware) (código em C) junto também com o nome e senha do wifi que será conectado ao esp. Após isso, ainda no [Firebase](https://firebase.google.com/), você vai precisar configurar um aplicativo Android e/ou iOS e seguir os passos necessários para adicionalos no arquivo do 
 [software](https://github.com/RaphaelRat/Planta-Care/tree/main/software/aplicacao), que foi desenvolvido em [Flutter](https://flutter.dev/). Para facilitar essa comunicação com o Hardware você pode acessar essa [documentação](https://randomnerdtutorials.com/esp8266-nodemcu-firebase-realtime-database/) e para a comunicação com a aplicação, pode ver essa [documentação](https://firebase.flutter.dev/docs/database/usage/).
 
 ## O hardware
 
 Aqui temos respectivamente imagens do ESP32 utilizado para o sensor de umidade do solo sozinho e montado com os componentes e o protoboard com os componentes para a temperatura e umidade ambiente e para o servo-motor: 
 
 >  <img src="https://user-images.githubusercontent.com/89277770/181349081-0048420a-0af8-45d5-bae0-e9f4d5b84fde.png" alt="ESP32" width="250"/> <img src="https://user-images.githubusercontent.com/89277770/181350828-9748fdd3-d0b5-446e-ba87-44ea9cc996a3.png" alt="Umidade solo" width="250"/> <img src="https://user-images.githubusercontent.com/89277770/181350734-1f387138-227f-45f7-a9bf-858c5353b742.png" alt="Umidade e temp ambiente" width="250"/> 

 
 Com tudo isso pronto, pensamos em como regariamos a planta, e para isso montamos a estrutura da imagem abaixo, onde furamos o fundo da garrafa e então fechamos com a tampa (quando a tampa abrir a agua vai vazar por baixo) e fizemos as ligações.
 

 >  <img src="https://user-images.githubusercontent.com/89277770/181351375-43ec30c3-0fd8-4696-8c21-0db6900df2dd.png" alt="Estrutura" width="250"/>   <img src="https://user-images.githubusercontent.com/89277770/181351549-ae475302-f7c7-4373-804a-aede4fae4e63.png" alt="Estrutura pronta" width="250"/>   <img src="https://user-images.githubusercontent.com/89277770/181351567-3314e7d0-0b2c-4266-8d9b-c99774715876.png" alt="Estrutura pronta 2" width="250"/> 
  
 <br>
 
 ## O software
 
 Para a aplicação, foi feito no [Figma](figma.com) o seguinte protótipo abaixo, que conta com a lista das plantas que você já tem cadastradas, a estatística geral delas, uma página de perfil entre outros:
 
>  <img src="https://user-images.githubusercontent.com/89277770/181356735-47ce29fc-4fc7-4561-bf5e-2d7b89220634.png" alt="Protótipo" height="400"/>   <img src="https://user-images.githubusercontent.com/89277770/181357336-db058b08-8314-4d21-80a0-5b3bd582ba08.png" alt="Protótipo" height="400"/> 
>
> Entretanto, como todo final de semestre em qualquer faculdade conceituada, ninguém tem tempo para respirar, e por conta disso o desenvolvimento da aplicação teve um corte significativo no tempo e com isso não possui todas as funcionalidades como estatísticas, adicionar nova planta e pagina de perfil. Porém a página da planta está exatamente como no protótipo e funcionando perfeitamente, o que foi o necessário para apresentação do trabalho (pois exibia e transmitia dados para a nuvem).
 
 Então antes do desenvolvimento em si da aplicação, foi criado o banco de dados no Firebase, utilizando o [Realtime Database](https://firebase.google.com/products/realtime-database?gclid=Cj0KCQjwxIOXBhCrARIsAL1QFCZtZeGRcXVcGAR7SE7jqpvfo_ike4cbais5UjJEofKreE_B84bn0bMaAlDLEALw_wcB&gclsrc=aw.ds)(aka Nuvem). E para sua implementação, exemplificamos inicialmente 3 plantas com os mesmos atributos, porém valores diferentes. Então o banco ficou deste jeito: 


 >  <img src="https://user-images.githubusercontent.com/89277770/181358841-3d22d8fd-a959-40e2-88f6-90b469d491c0.png" alt="Database" width="250"/>
 

 <br>
 
 ## O trabalho
 
 Para apresentação, todos os integrantes do grupo falaram um pouco sobre o progeto em geral e um pouco sobre o que fez dentro da equipe. A apresentação (slides) pode ser baixada [aqui](https://github.com/RaphaelRat/Planta-Care/files/9203318/PlantCare.APP.pdf).

> <img src="https://user-images.githubusercontent.com/89277770/181366297-8ba202a6-c798-4dd2-8073-dabc5298e06a.gif" alt="Slides" height="400"/>
 

<br>

## O resultado

Felizmente ficamos muito empolgados com o projeto e com o resultado, por conta disso, infelizmente não lembramos de gravar e tirar muitas fotos, todas as fotos tiradas acima foram depois da apresentação. Mas temos esse videozinho onde mostra a funcionalidade regar e da para ver a tela da planta onde exibe os dados do local (dados reais do momento da gravação do vídeo).

> https://user-images.githubusercontent.com/89277770/181367449-14fc0c23-67bb-4e37-9e3b-3ec5986e56ea.mp4
> 
> Ps: A garrafa está sem água pois utilizamos toda a água na hora da apresentação (a coitada passa bem, foi a medida de água necessária, nada a mais e nada a menos).

 <br>
 
 ## A equipe
 
 Não repare na beleza dos integrantes. 
 
> ![Equipe](https://user-images.githubusercontent.com/89277770/181367194-3eff9353-050d-44ea-bbc0-2bd4872f92c2.png)
>
> Na ordem: Matheus Amboni,  Bruno Antonelli, Leomar Marcelo Marschalk, Yan Bentes, Raphael Abreu.

 
 -----------
 
 #### Visitantes: 
 
 <img alingn="center" src="https://profile-counter.glitch.me/r4t-planta-care/count.svg" />
 
-----
