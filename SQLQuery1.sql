-- 1.
-- What grades are stored in the database?

-- School Grades 1 through and including 5

--SELECT * FROM Grade;


-- 2.
-- What emotions may be associated with a poem?

-- A range of emotions is possible(fig1). For the scope of our databasing technique, so far 4 emotions are available to be used in our database(fig2).

/*
fig1 - Poems And Their Respective Emotions
*/
--SELECT p.Title "Poem Titles", e.name "Emotion Represented"FROM PoemEmotion pe JOIN Emotion e ON pe.EmotionId = e.id JOIN Poem p ON pe.PoemId = p.id;

/*
fig2 - Current Emotions In Our Database
*/
--SELECT Name "Current Emotions In Our Database" FROM Emotion


-- 3.
-- How many poems are in the database?

-- 32,842 poems

/*
fig1 - A List of All Poems, Authors Included
*/
--SELECT p.Title Poem, a.Name Author FROM Poem p JOIN Author a ON p.AuthorId = a.Id;

/*
fig2 - A Count of All Poems. Just The Numbers.
*/
--SELECT COUNT(p.Id) "Total Peoms" FROM Poem p;


-- 4.
-- Sort authors alphabetically by name. What are the names of the top 76 authors?

-- This code sorts and lists the authors as desired.

/*
SELECT TOP 76
a.Name "Poet Name"
FROM Author a 

ORDER BY a.Name ASC;
*/


-- 5.
-- Starting with the above query, add the grade of each of the authors.

-- This code sorts and lists the authors as desired.

/*
SELECT TOP 76
a.Name "Poet Name", 
g.Name "Grade Level" 
FROM Author a 
JOIN Grade g on a.GradeId = g.Id 
ORDER BY a.Name ASC;
*/


-- 6.
-- Starting with the above query, add the recorded gender of each of the authors.

-- This code sorts and lists the authors as desired.

/*
SELECT TOP 76
a.Id ID,
a.Name "Poet Name", 
g.Name "Grade Level", 
ge.Name "Gender" 
FROM Author a 
JOIN Grade g on a.GradeId = g.Id 
JOIN Gender ge on a.GenderId = ge.Id
ORDER BY a.Name ASC;
*/


-- 7.
-- What is the total number of words in all poems in the database?

-- There are 374,584 total words in all poems in the database.

--SELECT SUM(p.WordCount) "Word Count From All Peoems" FROM Poem p


-- 8.
-- Which poem has the fewest characters?

-- This is a list of all the poems witht the least amount of words.

/*
SELECT
Title, 
MIN(WordCount) "Word Count"
FROM Poem
WHERE WordCount < 1
GROUP BY Title;
*/


-- 9.
-- How many authors are in the third grade?

-- This code sorts and lists the authors as desired.

/*
SELECT COUNT(*) "3rd Grade Authors"

FROM (SELECT a.Name Poet, g.Name "Grade Level"
FROM Author a 
JOIN Grade g ON g.id = a.GradeId
WHERE g.Name = '3rd Grade') src;
*/


-- 10.
-- How many total authors are in the first through third grades?

-- There are 4,404 Authors from the 1st to & including 3rd Grades.

/*
SELECT TOP 3
COUNT(a.Id) "Total Authors 1st-3rd Grade"
FROM Author a
JOIN Grade g ON g.Id = a.GradeId
WHERE g.Name = '1st grade' OR g.Name = '2nd grade' OR g.Name = '3rd grade';
*/


-- 11.
-- What is the total number of poems written by fourth graders?

-- The 4th Grade has written 21,036 Poems in our database.

/*
SELECT
g.Name,
COUNT(p.Id) "Total Poems"
FROM Poem P
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON pe.EmotionId = e.Id
JOIN Author a ON a.Id = p.AuthorId
JOIN Grade g ON g.Id = a.GradeId
WHERE g.name = '4th Grade'
GROUP BY g.Name
ORDER BY COUNT(p.Id);
*/

-- 12.
-- How many poems are there per grade?

-- 1st Grade has 1,514 Poems. 2nd Grade has 5,411 Poems. 3rd Grade has 11,978 Poems. 4th Grade has 21,036 Poems. 5th Grade has 24,092 Poems.

/*
SELECT
g.Name,
COUNT(p.Id) "Total Poems"
FROM Poem P
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON pe.EmotionId = e.Id
JOIN Author a ON a.Id = p.AuthorId
JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Name
ORDER BY COUNT(p.Id);
*/

-- 13.
-- How many authors are in each grade? (Order your results by grade starting with 1st Grade)

-- There are 623 authors in the 1st Grade. There are 1437 authors in the 2nd Grade. There are 2344 authors in the 3rd Grade. There are 3288 authors in the 4th Grade. There are 3464 authors in the 5th Grade.

/*
SELECT
g.Name "Grade Level",
COUNT(a.Id) "Total Authors Each Grade"
FROM Author a
JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Name
ORDER BY g.Name;
*/


-- 14.
-- What is the title of the poem that has the most words?

-- The Misterious Black, by Ansley, has a word count of 263. That makes it the poem with the most words.

--SELECT TOP 1 Title, a.Name, WordCount FROM Poem p JOIN Author a ON a.Id = p.AuthorId ORDER BY WordCount DESC


-- 15.
-- Which author(s) have the most poems? (Remember authors can have the same name.)

-- The Author Jessica wrote the most with 118 poems.

/*
SELECT Top 1 count(p.AuthorId) "Poems Written", a.Name
FROM Author a
LEFT JOIN Poem p ON p.AuthorId = a.Id
GROUP BY p.AuthorId, a.Name
ORDER BY count(p.AuthorId) DESC;
*/

-- 16.
-- How many poems have an emotion of sadness?

-- There are 14,570 poems in our database on the subject of sadness

/*
SELECT COUNT(*) "Poems About Sadness"
FROM Poem p
JOIN PoemEmotion pe ON pe.PoemId = p.id
JOIN Emotion e ON pe.EmotionId = e.id
WHERE e.Name = 'Sadness';
*/


-- 17.
-- How many poems are not associated with any emotion?

-- 3368 poems are not associated with any emotion in our database.

/*
SELECT COUNT(*) "Poems Without Emotions"
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.id
WHERE pe.Id IS NULL;
*/


-- 18.
-- Which emotion is associated with the least number of poems?

-- Anger is associated 11,105, so the least amount.

/*
SELECT Top 1 e.Name, count(pe.EmotionId) "Times The Emotion Is Associated"
FROM PoemEmotion pe
LEFT JOIN Emotion e ON pe.EmotionId = e.Id
GROUP BY pe.EmotionId, e.Name
ORDER BY count(pe.EmotionId);
*/


-- 19.
-- Which grade has the largest number of poems with an emotion of joy?

-- the 5th Grade has the most poems about Joy- there are 8,928 poems about joy in the 5th Grade.

/*
SELECT
g.Name,
COUNT(p.Id) "Poems About Joy"
FROM Poem P
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON pe.EmotionId = e.Id
JOIN Author a ON a.Id = p.AuthorId
JOIN Grade g ON g.Id = a.GradeId
WHERE e.Name='Joy'
GROUP BY g.Name
ORDER BY COUNT(p.Id) DESC;
*/


-- 20.
-- Which gender has the least number of poems with an emotion of fear?

-- Female authors have written the most, with 2,411 poems in our database being written about fear from that gender group.

/*
SELECT TOP 1 g.Name, count(a.genderId) "Poems About Fear"
FROM Poem p
LEFT JOIN Author a ON a.id = p.AuthorId
LEFT JOIN Gender g ON g.id = a.GenderId
LEFT JOIN PoemEmotion pe ON p.id = pe.PoemId
LEFT JOIN Emotion e ON e.id = pe.EmotionId
WHERE e.Name = 'Fear'
GROUP BY a.GradeId, g.Name
ORDER BY count(a.GenderId) DESC;
*/
