-- Mert was here


-- 1.SORU

--  NOTE: SELECT posts.title, users.username, categories.name as category FROM posts şeklinde getirirsen kategori sütun adı daha açıklayıcı olacaktır
SELECT Posts.title, Users.username, Categories.name FROM Posts
JOIN Users ON Posts.user_id = Users.user_id
JOIN Categories ON Posts.category_id = Categories.category_id;

-- 2.SORU
/*SELECT Posts.title, Users.username, Posts.creation_date FROM Posts
JOIN Users ON Posts.user_id = Users.user_id
WHERE Posts.is_published = true
ORDER BY creation_date DESC
LIMIT 5;*/

-- 3.Soru
/*SELECT Posts.title, COUNT(Comments.comment) FROM Posts
JOIN Comments ON Posts.post_id = Comments.post_id
GROUP BY Posts.title;*/

--4. Tüm kayıtlı kullanıcıların kullanıcı adlarını ve e-posta adreslerini gösterin.
/*SELECT username, email FROM Users;*/

--5. En son 10 yorumu, ilgili gönderi başlıklarıyla birlikte alın.
/*SELECT Posts.title, Comments.comment, Comments.creation_date FROM Posts
JOIN Comments ON Posts.post_id = Comments.post_id
ORDER BY Comments.creation_date DESC
LIMIT 10;*/

--6. Belirli bir kullanıcı tarafından yazılan tüm blog yazılarını bulun.
/*SELECT  Users.username, Posts.title FROM Posts
JOIN Users ON Posts.user_id = Users.user_id
WHERE Users.user_id = 1;*/

--7. Her kullanıcının yazdığı toplam gönderi sayısını alın.
/*SELECT  Users.username, COUNT(Posts.title) FROM Posts
JOIN Users ON Posts.user_id = Users.user_id
GROUP BY username;*/

--8. Her kategoriyi, kategorideki gönderi sayısıyla birlikte gösterin.
/*SELECT Categories.name, COUNT(Posts.title) FROM Categories
JOIN Posts ON  Categories.category_id = Posts.category_id
GROUP BY Categories.name;*/

--9. Gönderi sayısına göre en popüler kategoriyi bulun.
/*SELECT Categories.name, COUNT(Posts.title) FROM Categories
JOIN Posts ON  Categories.category_id = Posts.category_id
GROUP BY Categories.name
ORDER BY COUNT(Posts.title) DESC
LIMIT 1;*/

--10. Gönderilerindeki toplam görüntülenme sayısına göre en popüler kategoriyi bulun.
/*SELECT Categories.name, sum(view_count) FROM Categories
JOIN Posts ON  Categories.category_id = Posts.category_id
GROUP BY Categories.name
ORDER BY sum(view_count) DESC
LIMIT 1*/

--11. En fazla yoruma sahip gönderiyi alın
/*SELECT Posts.title, COUNT(Comments.comment_id) FROM Posts
JOIN Comments ON Posts.post_id = Comments.post_id
GROUP BY Posts.title
ORDER BY COUNT(Comments.comment_id) DESC
LIMIT 1*/

--12. Belirli bir gönderinin yazarının kullanıcı adını ve e-posta adresini gösterin.
/*SELECT  Users.username, Users.email, Posts.title FROM Posts
JOIN Users ON   Posts.user_id =Users.user_id 
WHERE Posts.post_id = 5*/

--13. Başlık veya içeriklerinde belirli bir anahtar kelime bulunan tüm gönderileri bulun.
SELECT * FROM Posts
WHERE title ILIKE '%an%' -- OR content ILIKE '%an%';

-- NOTE: Soruda başlık veya içeriklerinde ibaresi geçtiğindne içerik içinde de arama yapmamız gerekmekte. Yukarıdaki kod bloğunu da sorguna eklemen gerekmekte bu durumda

--14. Belirli bir kullanıcının en son yorumunu gösterin.
/*SELECT Users.username, Comments.comment, Comments.creation_date FROM Users 
JOIN Comments ON Users.user_id = Comments.user_id
WHERE Users.user_id=2
ORDER BY Comments.creation_date DESC
LIMIT 1;*/

--15. Gönderi başına ortalama yorum sayısını bulun.
/*SELECT AVG(comment_count) AS average_comment_count
FROM (
    SELECT p.post_id, COUNT(c.comment_id) AS comment_count
    FROM Posts p
    LEFT JOIN Comments c ON p.post_id = c.post_id
    GROUP BY p.post_id
) AS subquery;*/

--16. Son 30 günde yayınlanan gönderileri gösterin. -- YOK
SELECT title, creation_date FROM Posts
WHERE is_published = 'true' AND creation_date BETWEEN CURRENT_DATE - INTERVAL '300 days' AND CURRENT_DATE;

--17. Belirli bir kullanıcının yaptığı yorumları alın.
/*SELECT Users.username, Comments.comment FROM Comments 
JOIN Users  ON Comments.user_id = Users.user_id
WHERE Users.user_id = 3;*/

--18. Belirli bir kategoriye ait tüm gönderileri bulun.
/*SELECT Categories.name, Posts.title FROM Categories
JOIN Posts ON  Categories.category_id = Posts.category_id
WHERE Categories.name = 'Sports'*/

--19. 5'ten az yazıya sahip kategorileri bulun. --YOK
/*SELECT Categories.name, COUNT(Posts.title) FROM Categories
JOIN Posts ON  Categories.category_id = Posts.category_id
GROUP BY Categories.name
HAVING COUNT(Posts.title) < 5*/

--20. Hem bir yazı hem de bir yoruma sahip olan kullanıcıları gösterin.

-- NOTE: Soruyu en az bir post ve en az bir commenti bulunan userları getirin şeklinde anladın muhtemelen. Bu mantıkla kodun doğru çalışmakta ancak soruda bizden bir tane postu ve bir tane comment'i bulunan sorguyu istemiş. Soruda açıkça belirtilmediğinden doğru kabul edildi. Yine de doğru sorguyu bırakıyorum

-- SELECT users.* FROM users JOIN posts ON posts.user_id = users.user_id
-- JOIN comments ON comments.user_id = users.user_id
-- GROUP BY users.user_id
-- HAVING COUNT(posts) = 1 AND COUNT(comments) = 1;

SELECT Users.user_id, Users.username FROM  Users
JOIN Posts ON Users.user_id = Posts.user_id
JOIN Comments ON Posts.post_id = Comments.comment_id
GROUP BY Users.user_id, Users.username
HAVING COUNT(DISTINCT Posts.post_id) >= 1 AND COUNT(DISTINCT Comments.comment_id) >= 1;

--21. En az 2 farklı yazıya yorum yapmış kullanıcıları alın.
/*SELECT Users.user_id, Users.username FROM Users
JOIN Comments ON Users.user_id = Comments.user_id
WHERE Comments.post_id IN (
    SELECT post_id
    FROM Comments
    GROUP BY post_id
    HAVING COUNT(DISTINCT user_id) >= 2
)
GROUP BY Users.user_id, Users.username
HAVING COUNT(DISTINCT Comments.post_id) >= 2;*/

--22. En az 3 yazıya sahip kategorileri görüntüleyin.

-- NOTE: 1'den fazla posts.title geldiği için ve group by'da categories.name sütununa göre grupla komutu verdiğin için bir conflict durumu var. Doğru sorguyu aşağıdan inceleyebilirsin

-- SELECT categories.name, COUNT(posts.post_id) AS post_count
-- FROM categories
-- JOIN posts ON categories.category_id = posts.category_id
-- GROUP BY categories.category_id
-- HAVING COUNT(posts.post_id) >= 3;

SELECT Categories.name, Posts.title FROM Posts
JOIN Categories ON Posts.category_id = Categories.category_id
GROUP BY Categories.name
HAVING COUNT(Posts.post_id) > 3;

--23. 5'ten fazla blog yazısı yazan yazarları bulun
/*SELECT Users.user_id, Users.username FROM Users
JOIN Posts ON Users.user_id = Posts.user_id
GROUP BY Users.user_id, Users.username
HAVING COUNT(DISTINCT Posts.post_id) > 5;*/

/*24. Bir blog yazısı yazmış veya bir yorum yapmış kullanıcıların e-posta adreslerini
görüntüleyin. (UNION kullanarak)*/

/*(SELECT Users.email FROM Users
JOIN Posts ON Users.user_id = Posts.user_id
GROUP BY Users.user_id, Users.email
HAVING COUNT(DISTINCT Posts.post_id) >= 1)
UNION
(SELECT Users.email FROM Users
JOIN Comments ON Users.user_id = Comments.user_id
GROUP BY Users.user_id, Users.email
HAVING COUNT(DISTINCT Comments.comment_id) >= 1);*/

--25. Bir blog yazısı yazmış ancak hiç yorum yapmamış yazarları bulun.
/*SELECT Users.username FROM Users
JOIN Posts ON Users.user_id = Posts.user_id
JOIN (
    SELECT post_id, COUNT(comment_id) AS comment_count FROM Comments
    GROUP BY post_id
) AS CommentCounts ON CommentCounts.post_id = Posts.post_id 
WHERE CommentCounts.comment_count = 0;*/

/*SELECT Users.username FROM Users
JOIN Posts ON Users.user_id = Posts.user_id
JOIN Comments ON Posts.post_id = Comments.post_id
GROUP BY Users.username
HAVING COUNT(Comments.comment_id) = 0;*/










