# Audit

Аудит всей деятельности сообществ, представленный в дружелюбном к роботам виде.

## Назначение
Данный репозиторий - это самый полный архив всех встреч, спикеров, докладов, слайдов, видеозаписей и прочих артефактов активности [DotNetRu](http://dotnet.ru). Его основная цель - быть единым источником данных для всех последующих представлений ([сайтов](http://dotnet.ru/), [энциклопедий](https://github.com/AnatolyKulakov/SpbDotNet/wiki/SpbDotNet), [приложений](https://github.com/DotNetRu/App), [видеотек](https://www.youtube.com/channel/UCHFl23Ah_l4gEUTXYUStQdQ), статистике и т.д.).

## Формат

Аудит хранится в виде xml файлов с чрезвычайно простой и интуитивно понятной структурой. Формально пока существует только [модель в PowerShell](https://github.com/AnatolyKulakov/Boombr/blob/master/src/Model.ps1).

Основная структура:

DotNetRu состоит из [Сообществ](https://github.com/DotNetRu/Audit/tree/master/db/communities). Каждое сообщество регулярно собирает [Встречи](https://github.com/DotNetRu/Audit/tree/master/db/meetups). Встречи проходят на какой-то [Площадке](https://github.com/DotNetRu/Audit/tree/master/db/venues) при поддержке наших [Друзей](https://github.com/DotNetRu/Audit/tree/master/db/friends). На встречах [Докладчики](https://github.com/DotNetRu/Audit/tree/master/db/speakers) читают [Доклады](https://github.com/DotNetRu/Audit/tree/master/db/talks).
