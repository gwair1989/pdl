# PDL

### Общее

Display name - Payday Loans

Название проекта - Payday Loans

Иконка - в проекте Figma

LauchScreen - иконка проекта.

Дизайн - https://www.figma.com/file/JGGg5MwNvOZH3j7CvU2l5o/Pay-Day-Loans?node-id=0%3A1

UIKit либо SwiftUI - как будет быстрее

Стандартный иосвский TabBar, все иконки в приложении взяты с SF Symbols, подписаны в фигме реальными названиями, чтоб можно было указать в Image(systemName: “reminder”).

# Этап 2

**Интеграции:**

– Firebase Analytics;

– Firebase Push Notifications;
– Firebase Remote Config.

– Appsflyer;

---

Дай пожалуйста свой имейл, чтоб я тебя добавил в Firebase и Appsflyer.

Скрипт загружать в приложение с Firebase Remote Config.

### *Script:*

<script type="text/javascript">

var _lg_form_init_ = {

"aid": 14325,

"formToken": "cd92d781"

};

</script>

<script type="text/javascript" async="true" src="https://loansaccount.com/form/applicationInit.js"></script>

<div id="_lg_form_"></div>

Добавить в Remote Config поле isEnabled.

Если *false*, то будет такое же приложение, как и на этап 1.

Если *true* ↓

При заполнении данных и нажатии на next step открывается webview, со скриптом (который подгружается с firebase). 

Заполненные данные должны автоматически подставиться в поля скрипта на webview.


# Этап 1

### Экран Loan

Все данные, которые вводятся никуда не записываются.

**Первый слайд**

Loan amount - вместо клавы вылазит пикер с вариантами:

200$ - 500$

500$ - 1000$

1000$ - 2500$

2500$ - 5000$

Your email - стоит проверка на правильность ввода. В фигме есть дизайн состояний неправильного и правильного ввода. Если ввод неправильный - перейти на след. слайд нельзя.

Last 4 numbers of SSN - маска, вида *** - ** - 1234 (*** - ** - всегда остаются, можно ввести только 4 последние цифры)

**Второй слайд**

Zip code - только цифры.

Date of birth - вместо клавы дата пикер.

**Последний слайд**

При переходе на него - 0%, и плавная загрузка до 100% за 5 сек.

Кольцо также должно быть анимировано - 0% - полностью серое, 100% - полностью салатовое.

После тапа на “Confirm” - Alert (Successfully).

### Экран Reminder

При нажатии на дату - Date Picker

При нажатии на Repeat - Пикер с вариантами Never/Repeat.


### Экран Calculator

Расчет по формуле 

[https://wpcalc.com/kalkulyator-mikrozajma/](https://wpcalc.com/kalkulyator-mikrozajma/)

### Экран Personal

Privacy Policy, Responsible Lending, Terms of Conditions - дизайн просто текст
