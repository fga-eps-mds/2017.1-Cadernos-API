# 2017.1-Cadernos-API
 Repositório oficial da API do projeto de cadernos de arte da Universidade de Brasília. Link para o repositorio central do projeto: https://github.com/fga-gpp-mds/2017.1-Cadernos-APP/.

***

[![Code Climate](https://codeclimate.com/github/fga-gpp-mds/2017.1-Cadernos-API/badges/gpa.svg)](https://codeclimate.com/github/fga-gpp-mds/2017.1-Cadernos-API)
[![Build Status](https://travis-ci.org/fga-gpp-mds/2017.1-Cadernos-API.svg?branch=homolog)](https://travis-ci.org/fga-gpp-mds/2017.1-Cadernos-API)
[![Coverage Status](https://coveralls.io/repos/github/fga-gpp-mds/2017.1-Cadernos-API/badge.svg?branch=homolog)](https://coveralls.io/github/fga-gpp-mds/2017.1-Cadernos-API?branch=master)


***

## Instalação

Para rodar a API do aplicativo cadernos localmente basta clonar repositório e execultar
o seguintes comandos:

```bash
vagrant up mdsgpp
vagrant ssh mdsgpp
```

Após a inicialização da maquina virtual, execulte:

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
