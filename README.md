# Audit

[![Build status](https://ci.appveyor.com/api/projects/status/66po2pqg20s38kmi/branch/master?svg=true)](https://ci.appveyor.com/project/AnatolyKulakov/audit)

Аудит всей деятельности сообществ, представленный в дружелюбной к роботам форме.

## Назначение

Данный репозиторий - это самый полный архив всех встреч, спикеров, докладов, слайдов, видеозаписей и прочих артефактов активности [DotNetRu](http://dotnet.ru). Его основная цель - быть единым источником данных для всех последующих представлений ([сайтов](http://dotnet.ru/), [энциклопедий](https://github.com/AnatolyKulakov/SpbDotNet/wiki/SpbDotNet), [приложений](https://github.com/DotNetRu/App), [видеотек](https://www.youtube.com/DotNetRu), статистике и т.д.).

## Формат

Аудит хранится в виде xml файлов с чрезвычайно простой и интуитивно понятной структурой.

### Логическая структура

DotNetRu состоит из [Сообществ](db/communities). Каждое сообщество регулярно собирает [Встречи](db/meetups). Встречи проходят на какой-то [Площадке](db/venues) при поддержке наших [Друзей](db/friends). На встречах [Докладчики](db/speakers) читают [Доклады](db/talks).

### Формальная структура

- [Xml Schema](schemas)
- [PowerShell](https://github.com/AnatolyKulakov/Boombr/blob/master/src/Model.ps1)
