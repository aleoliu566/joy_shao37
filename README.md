# Data-Model-project-2

> deadline: 11/27

[ER model](https://drive.google.com/file/d/1JMJ7KX2RuAfdIa2wOI_k9BFusvt-ZN86/view?usp=sharing)

主要分成三個架構
- User端
- Enterprise端
- Admin端

分工
- 劉　皪：User
- 邵家怡：(Enterprise) Job、收藏、Job tag
- 張月馨：(Enterprise) Company、Article
- 賴立芸：(Admin) Admin
- 黃懷萱：前端介面

- 文件（英文）：一起

---

### 執行步驟

1.安裝rails 5

- [教學1: 為你自己學 Ruby on rails](http://railsbook.tw/chapters/02-environment-setup.html)
- [教學2: Google](https://www.google.com.tw/)(請善用谷歌大神)


2.在terminal中執行
```
git clone https://github.com/aleoliu566/joy_shao37.git
```

3.安裝gem
```
bundle
```

4.migrate(設定資料庫)
```
rails db:migrate
```

5.啟動伺服器
```
rails s
```

6.新增假資料
```
rails db:seed
```

測試資料

一般使用者
- 帳號:test1@gmail.com
- 密碼:12345678

Admin帳號
- 帳號:admin@gmail.com
- 密碼:12345678

Company帳號  (屬於google的HR)
- 帳號:company@gmail.com
- 密碼:12345678


###參考資料

Ruby on rails
* [Google](www.google.com)
* [ Ruby on rails 實戰聖經 ](https://ihower.tw/rails/)
* [為你自己學 Ruby on rails](http://railsbook.tw/)
* [RubyGuide](https://rails.ruby.tw/)
* 

Html CSS
* [w3school](https://www.w3schools.com/) 

Git
* [為你自己學git](http://gitbook.tw/)
* 莊老師lab有書可以看，什麼24堂課

