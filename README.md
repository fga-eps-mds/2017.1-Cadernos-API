# 2017.1-Cadernos-API
 Repositório oficial do projeto de cadernos de arte da Universidade de Brasília

***

[![Code Climate](https://codeclimate.com/github/fga-gpp-mds/2017.1-Cadernos-API/badges/gpa.svg)](https://codeclimate.com/github/fga-gpp-mds/2017.1-Cadernos-API)
[![Build Status](https://travis-ci.org/fga-gpp-mds/2017.1-Cadernos-API.svg?branch=homolog)](https://travis-ci.org/fga-gpp-mds/2017.1-Cadernos-API)
[![Coverage Status](https://coveralls.io/repos/github/fga-gpp-mds/2017.1-Cadernos-API/badge.svg?branch=homolog)](https://coveralls.io/github/fga-gpp-mds/2017.1-Cadernos-API?branch=master)


***

## Utilizando a API

Para rodar a API do aplicativo cadernos localmente basta clonar repositório e execultar
o seguintes comandos:

```bash
vagrant up
```

Após a inicialização da maquina virtual, execulte:

```bash
cd /vagrant
rails s
```

Pronto! A API estará disponível em `http://localhost:3000`.

Vale lembrar que é necessario instalar o Vagrant e o Virtualbox antes. Para saber como instalar
confira o passo a passo na página da wiki [Configuracao Ambiente Dev](https://github.com/fga-gpp-mds/2017.1-Cadernos-API/wiki/Configuracao-Ambiente-Dev#vagrant-e-virtualboxt)
