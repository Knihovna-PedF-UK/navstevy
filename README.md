# Počítání návštěv v knihovně

Skript počítá počet návštěv v knihovně z počtu půjčení a vrácení - takže je v
tom započítaný i bibliobox a výdejní boxy. Jako jedna návštěva se počítají
všechny výpůjčky a vracení pro jednoho čtenáře v jeden den. Takže i když tu byl
fyzicky vícekrát, počítá se jen jednou.

## XML soubor z Almy

V `Analýzách` v Almě zvolíme `Výpůjční služby`. Tam vyhledáme výpůjčky za daný
časový období pro Faculty of Education. Nic víc tam není třeba nastavovat.
Výsledek stáhneme jako XML soubor.

## Zpracování souboru

    $ texlua navstevy.lua Loans\ by\ User\ Group.xml

Vypíše počet návštěvníků

