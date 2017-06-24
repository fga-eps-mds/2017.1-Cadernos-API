# 2017.1-Cadernos-API
 Repositório oficial da API do projeto de cadernos de arte da Universidade de Brasília. Link para o repositório central do projeto: https://github.com/fga-gpp-mds/2017.1-Cadernos-APP/.

***

[![Code Climate](https://codeclimate.com/github/fga-gpp-mds/2017.1-Cadernos-API/badges/gpa.svg)](https://codeclimate.com/github/fga-gpp-mds/2017.1-Cadernos-API)
[![Build Status](https://travis-ci.org/fga-gpp-mds/2017.1-Cadernos-API.svg?branch=homolog)](https://travis-ci.org/fga-gpp-mds/2017.1-Cadernos-API)
[![Coverage Status](https://coveralls.io/repos/github/fga-gpp-mds/2017.1-Cadernos-API/badge.svg?branch=homolog)](https://coveralls.io/github/fga-gpp-mds/2017.1-Cadernos-API?branch=master)


***
## API Graph

Visualização gráfica das conexões da API, disponível em: https://colaborart.github.io

> PS: O Heroku pode estar dormindo, então caso não apareça nada, aguarde uns 20 segundos e atualize a página

***

## Rotas

|     Verbo    |           Url          | Descrição                                                                                  | Parâmetros aceitos                                                                                                                 |
|:------------:|:----------------------:|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| POST         | /authenticate          | Autentifica o usuário.                                                                     | email: string password: string                                                                                                     |
| GET          | /book/search/:keyword  | Busca por um caderno                                                                       | keyword: string                                                                                                                    |
| GET          | /books                 | Disponibiliza os cadernos em ordenados pelo seu título e com paginação                     | page: number per_page: number, default: 10                                                                                         |
| POST         | /books                 | Cria um novo caderno.                                                                      | book => { title: string, user_id: number }                                                                                         |
| GET          | /books/:id             | Disponibiliza os dados de um único caderno                                                 | id: number                                                                                                                         |
| PUT or PATCH | /books/:id             | Atualiza os dados de um caderno                                                            | book => { title: string, user_id: number }                                                                                         |
| DELETE       | /books/:id             | Deleta um caderno                                                                          | id: number                                                                                                                         |
| GET          | /books-all             | Disponibiliza todos os cadernos, sem paginação e ordenados pelo id                         |                                                                                                                                    |
| GET          | /books/:id/:title.pdf  | Gera um PDF do caderno. PS: O títutlo pode ser qualquer coisa, ele não é usado pra nada... | id: number title: string                                                                                                           |
| POST         | /books/:id/cover       | Seta uma capa para um dado caderno. A imagem é passada como parâmetro no formato base64.   | id: number cover_base: image string base64                                                                                         |
| GET          | /books/:id/members     | Disponibiliza os colaboradores de um caderno                                               | id: number                                                                                                                         |
| GET          | /books/:id/tasks       | Disponibiliza as tarefas de um caderno                                                     | id: number                                                                                                                         |
| GET          | /categories            | Disponibiliza as categorias                                                                |                                                                                                                                    |
| GET          | /invites               | Disponibiliza os convites de colaboração                                                   |                                                                                                                                    |
| POST         | /invites               | Cria um convite de colaboração. Um email é enviado para o convidado                        | invite => {email: string, send_id: number, book_id: number}                                                                        |
| GET          | /memberships           | Disponibiliza as colaborações                                                              |                                                                                                                                    |
| POST         | /memberships           | Cria uma colaboração                                                                       | membership => {email: string, book_id: number}                                                                                     |
| GET          | /users                 | Disponibiliza os usuário                                                                   |                                                                                                                                    |
| POST         | /users                 | Cria um novo usuário                                                                       | user => {name: string, email: string, email_confirmation: string, password: string, password_confirmation: string}                 |
| GET          | /users/:id             | Disponibiliza os dados de um usuário                                                       | id: number                                                                                                                         |
| PUT or PATCH | /users/:id             | Atualiza os dados de um usuário                                                            | user => {name: string, email: string, email_confirmation: string, password: string, password_confirmation: string}                 |
| GET          | /users/:id/books       | Disponibiliza os cadernos que o usuário é dono                                             | id: number                                                                                                                         |
| GET          | /users/:id/invites     | Disponibiliza os convites de colaboração para o usuário                                    | id: number                                                                                                                         |
| GET          | /users/:id/memberships | Disponibiliza as colaborações do usuário                                                   | id: number                                                                                                                         |
| GET          | /tasks                 | Disponibiliza as tarefas                                                                   |                                                                                                                                    |
| POST         | /tasks                 | Cria uma nova tarefa                                                                       | task => {category_id: number, title: string, content: string, book_id: number, user_id: number, picture_base: string image base64} |
| GET          | /tasks/:id             | Disponibiliza os dados uma tarefa                                                          | id: number                                                                                                                         |
| PUT or PATCH | /tasks/:id             | Atualiza os dados de uma tarefa                                                            | id: number                                                                                                                         |
| DELETE       | /tasks/:id             | Deleta uma tarefa                                                             | id: number |
| POST         | /tasks/:id/picture     | Seta uma imagem para a terefa                                                 | id: number, picture_base: string image base64 |

***
## Instalação

Para inicializar a API do aplicativo Cadernos localmente basta clonar o repositório e executar o seguintes comandos:

```bash
vagrant up mdsgpp
vagrant ssh mdsgpp
```

Após a inicialização da maquina virtual, execute:

```bash
cd /vagrant
rails s -b 0.0.0.0
```

Pronto! A API estará disponível em `http://localhost:3000`.

Vale lembrar que é necessario instalar o Vagrant e o Virtualbox antes. Para saber como instalar
confira o passo a passo na página da wiki [Configuracao Ambiente Dev](https://github.com/fga-gpp-mds/2017.1-Cadernos-API/wiki/Configuracao-Ambiente-Dev#vagrant-e-virtualboxt)

## Como contribuir

1. Faça o download ou clone do repositório.
```console
$ git clone https://github.com/fga-gpp-mds/2017.1-Cadernos-API.git
```
2. Teste suas alterações dentro de uma branch própria e faça o Pull Request que será posteriormente analisado.


## Documentação

A documentação e todas as informações sobre o projeto se encontram em: https://github.com/fga-gpp-mds/2017.1-Cadernos-API/wiki
