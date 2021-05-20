-- SELECT basics
-- 1.
SELECT population FROM world
  WHERE name = 'Germany'
-- 2.
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway' ,'Denmark');
-- 3.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

-- Quiz 1
-- 1. Select the code which produces this table
SELECT name, population FROM world
  WHERE population BETWEEN 1000000 AND 1250000
-- 2. Pick the result you would obtain from this code:
Table-E 
Albania 	3200000
Algeria 	32900000
-- 3. Select the code which shows the countries that end in A or L 
SELECT name FROM world
  WHERE name LIKE '%a' OR name LIKE '%l'
-- 4. Pick the result from the query
name	length(name)
Italy	5
Malta	5
Spain	5
-- 5. Here are the first few rows of the world table:
Andorra	936
-- 6. Select the code that would show the countries with an area larger than 50000 and a population smaller than 10000000
SELECT name, area, population
  FROM world
  WHERE area > 50000 AND population < 10000000
-- 7. Select the code that shows the population density of China, Australia, Nigeria and France
SELECT name, population/area
  FROM world
  WHERE name IN ('China', 'Nigeria', 'France', 'Australia')

-- SELECT from world
-- 1
SELECT name, continent, population FROM world;
-- 2
SELECT name
  FROM world
  WHERE population > 200000000;
-- 3
SELECT name, gdp/population AS per_capita_GDP FROM world
  WHERE population >= 200000000 ORDER BY per_capita_GDP DESC;
-- 4
SELECT name, population/1000000 AS pop_in_millions FROM world
  WHERE continent = 'South America';
-- 5
SELECT name, population FROM world
  WHERE name IN ('France', 'Germany', 'Italy');
-- 6
SELECT name FROM world WHERE name LIKE '%United%';
-- 7
SELECT name, population, area FROM world
  WHERE area > 3000000 OR population > 250000000;
-- 8
SELECT name, population, area FROM world
  WHERE (area > 3000000 AND population < 250000000)
    OR (area < 3000000 AND population > 250000000);
-- 9
SELECT
    name,
    ROUND(population/1000000, 2) AS pop_in_millions,
    ROUND(GDP/1000000000, 2) GDP_in_billions
  FROM world
  WHERE continent = 'South America';
-- 10
SELECT name, ROUND((GDP/population)/1000,0)*1000 AS GPD_per_capita FROM world
  WHERE GDP > 1000000000000;
-- 11
SELECT name, capital FROM world
  WHERE LENGTH(name) = LENGTH(capital)
-- 12
SELECT name, capital FROM world
  WHERE LEFT(name, 1) = LEFT(capital, 1)
    AND name <> capital;
-- 13
SELECT name FROM world
  WHERE (name LIKE 'A%' OR name LIKE '%a%') AND
        (name LIKE 'E%' OR name LIKE '%e%') AND
        (name LIKE 'I%' OR name LIKE '%i%') AND
        (name LIKE 'O%' OR name LIKE '%o%') AND
        (name LIKE 'U%' OR name LIKE '%u%') AND
        (name NOT LIKE '% %');

-- Quiz 2
-- 1
SELECT name
  FROM world
  WHERE name LIKE 'U%'
-- 2
SELECT population
  FROM world
  WHERE name = 'United Kingdom'
-- 3
'name' should be name
-- 4
Nauru	990
-- 5
SELECT name, population
  FROM world
  WHERE continent IN ('Europe', 'Asia')
-- 6
SELECT name FROM world
  WHERE name IN ('Cuba', 'Togo')
-- 7
Brazil
Colombia

-- Select => Nobel 
-- 1
SELECT yr, subject, winner
  FROM nobel
  WHERE yr = 1950;
-- 2
SELECT winner
  FROM nobel
  WHERE yr = 1962 AND subject = 'Literature'
-- 3
SELECT yr, subject FROM nobel
  WHERE winner = 'Albert Einstein';
-- 4
SELECT winner FROM nobel
  WHERE yr > 1999 AND subject = 'Peace';
-- 5
SELECT yr, subject, winner FROM nobel
  WHERE yr BETWEEN 1980 AND 1989
    AND subject = 'Literature';
-- 6
SELECT * FROM nobel
 WHERE winner in ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama');
-- 7
SELECT winner FROM nobel WHERE winner LIKE 'John%';
-- 8
SELECT * FROM nobel
  WHERE (yr = 1980 AND subject = 'Physics')
    OR (yr = 1984 AND subject = 'Chemistry');
-- 9
SELECT * FROM nobel
  WHERE yr = 1980
    AND subject NOT IN ('Chemistry', 'Medicine');
-- 10
SELECT * FROM nobel
  WHERE (yr < 1910 AND subject = 'Medicine')
    OR (yr >= 2004 AND subject = 'Literature');
-- 11
SELECT * FROM nobel
  WHERE winner = 'Peter Grünberg';
-- 12
SELECT * FROM nobel
  WHERE winner = 'Eugene O''Neill';

-- Quiz 3
-- 1
SELECT winner FROM nobel
  WHERE winner LIKE 'C%' AND winner LIKE '%n'

-- 2
SELECT COUNT(subject) FROM nobel
  WHERE subject = 'Chemistry'
    AND yr BETWEEN 1950 and 1960

-- 3
SELECT COUNT(DISTINCT yr) FROM nobel
 WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')

-- 4
Medicine	Sir John Eccles
Medicine	Sir Frank Macfarlane Burnet

-- 5
SELECT yr FROM nobel
 WHERE yr NOT IN(SELECT yr 
                   FROM nobel
                 WHERE subject IN ('Chemistry','Physics'))

-- 6
SELECT DISTINCT yr
  FROM nobel
 WHERE subject='Medicine' 
   AND yr NOT IN(SELECT yr FROM nobel 
                  WHERE subject='Literature')
   AND yr NOT IN (SELECT yr FROM nobel
                   WHERE subject='Peace')

-- 7
Chemistry	1
Literature	1
Medicine	2
Peace	1
Physics	1

-- SUM & COUNT
-- 1
SELECT name FROM world
  WHERE population >
      (SELECT population FROM world
        WHERE name='Russia');
-- 2
SELECT name FROM world
  WHERE continent = 'Europe' 
    AND gdp/population > 
      (SELECT gdp/population FROM world
        WHERE name = 'United Kingdom')
-- 3
SELECT name, continent FROM world
  WHERE continent IN
    (SELECT DISTINCT continent FROM world
      WHERE name IN ('Argentina', 'Australia'))
        ORDER BY name;
-- 4
SELECT name, population FROM world
  WHERE population > (SELECT population FROM world WHERE name = 'Canada')
    AND population < (SELECT population FROM world WHERE name = 'Poland');
-- 5
SELECT name, CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany'), 0), '%') AS percentage FROM world WHERE continent = 'Europe';
-- 6
SELECT name FROM world
  WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp IS NOT NULL)
-- 7
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent = x.continent
          AND area IS NOT NULL);
-- 8
SELECT DISTINCT continent, name FROM world x
  WHERE name <= ALL (SELECT name FROM world y
                      WHERE x.continent = y.continent);
-- 9 
SELECT name, continent, population FROM world
  WHERE continent IN
    (SELECT DISTINCT continent FROM world x
      WHERE 25000000 >=
        ALL(SELECT population FROM world y
          WHERE x.continent = y.continent))
-- 10
SELECT name, continent FROM world x 
  WHERE x.population/3 >=
    ALL(SELECT population FROM world y
      WHERE y.continent = x.continent
        AND x.name != y.name) 
-- 1
SELECT region, name, population FROM bbc x WHERE population <= ALL (SELECT population FROM bbc y WHERE y.region=x.region AND population>0)
-- 2
SELECT name,region,population FROM bbc x WHERE 50000 < ALL (SELECT population FROM bbc y WHERE x.region=y.region AND y.population>0)
-- 3
SELECT name, region FROM bbc x
 WHERE population < ALL (SELECT population/3 FROM bbc y WHERE y.region = x.region AND y.name != x.name)
-- 4
-- Table-D
France
Germany
Russia
Turkey
-- 5
SELECT name FROM bbc
 WHERE gdp > (SELECT MAX(gdp) FROM bbc WHERE region = 'Africa')
-- 6
SELECT name FROM bbc
 WHERE population < (SELECT population FROM bbc WHERE name='Russia')
   AND population > (SELECT population FROM bbc WHERE name='Denmark')
-- 7
--Table-B
Bangladesh
India
Pakistan

-- SUM and COUNT
-- 1
SELECT SUM(population)
FROM world
-- 2
SELECT DISTINCT continent FROM world
-- 3
SELECT SUM(gdp) FROM world WHERE continent = 'Africa'
-- 4
SELECT COUNT(name) FROM world WHERE area >= 1000000
-- 5
SELECT SUM(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
-- 6
SELECT continent, COUNT(name) AS number_of_countries FROM world GROUP BY continent
-- 7
SELECT continent, COUNT(name) FROM world WHERE population >= 10000000 GROUP BY continent
-- 8
SELECT continent FROM world GROUP BY continent HAVING SUM(population) > 100000000

-- Quiz 4
-- 1
SELECT SUM(population) FROM bbc WHERE region = 'Europe'
-- 2
SELECT COUNT(name) FROM bbc WHERE population < 150000
-- 3
AVG(), COUNT(), MAX(), MIN(), SUM()
-- 4
No result due to invalid use of the WHERE function
-- 5
SELECT AVG(population) FROM bbc WHERE name IN ('Poland', 'Germany', 'Denmark')
-- 6
SELECT region, SUM(population)/SUM(area) AS density FROM bbc GROUP BY region
-- 7
SELECT name, population/area AS density FROM bbc WHERE population = (SELECT MAX(population) FROM bbc)
-- 8
--Table-D
Americas	732240
Middle East	13403102
South America	17740392
South Asia	9437710
-- 1
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
-- 2
SELECT id, stadium, team1, team2 FROM game
  WHERE id = 1012
-- 3
SELECT goal.player, goal.teamid, game.stadium, game.mdate FROM game JOIN goal ON goal.teamid = 'GER' AND goal.matchid = game.id
-- 4
SELECT game.team1, game.team2, goal.player FROM game JOIN goal WHERE goal.matchid = game.id AND player LIKE 'Mario%'
-- 5
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON teamid = id AND gtime <= 10
-- 6
SELECT mdate, teamname FROM game JOIN eteam ON team1 = eteam.id AND coach = 'Fernando Santos'
-- 7
SELECT player FROM goal JOIN game ON matchid = id AND stadium = 'National Stadium, Warsaw'
-- 8
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (teamid <> 'GER' AND (team1 = 'GER' OR team2 = 'GER'))
-- 9
SELECT teamname, COUNT(player) AS goals
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname
-- 10
SELECT stadium, COUNT(player) AS goals_scored FROM game JOIN goal ON id = matchid GROUP BY stadium
-- 11
SELECT matchid, mdate AS date, COUNT(teamid) AS goals
  FROM game JOIN goal ON matchid = id WHERE team1 = 'POL' OR team2 = 'POL' GROUP BY matchid, date
-- 12
SELECT matchid, mdate, COUNT(teamid) AS goals
  FROM game JOIN goal ON matchid = id WHERE teamid = 'GER' GROUP BY matchid, mdate
-- 13
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id
  GROUP BY mdate, matchid, team1, team2;
-- Quiz 5
-- 1
game  JOIN goal ON (id=matchid)
-- 2
matchid, teamid, player, gtime, id, teamname, coach
-- 3
SELECT player, teamid, COUNT(*)
  FROM game JOIN goal ON matchid = id
 WHERE (team1 = "GRE" OR team2 = "GRE")
   AND teamid != 'GRE'
 GROUP BY player, teamid
-- 4
DEN	9 June 2012
GER	9 June 2012
-- 5
  SELECT DISTINCT player, teamid 
   FROM game JOIN goal ON matchid = id 
  WHERE stadium = 'National Stadium, Warsaw' 
 AND (team1 = 'POL' OR team2 = 'POL')
   AND teamid != 'POL'
-- 6
SELECT DISTINCT player, teamid, gtime
  FROM game JOIN goal ON matchid = id
 WHERE stadium = 'Stadion Miejski (Wroclaw)'
   AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'))
-- 7
Netherlands	2
Poland	2
Republic of Ireland	1
Ukraine	2

-- JOIN
-- 1
SELECT id, title
 FROM movie
 WHERE yr=1962
-- 2 
SELECT yr FROM movie WHERE title = 'Citizen Kane'
-- 3
SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%' ORDER BY yr
-- 4
SELECT id FROM actor WHERE name = 'Glenn Close'
-- 5
SELECT id FROM movie WHERE title = 'Casablanca'
-- 6
SELECT name FROM actor JOIN casting ON id=actorid WHERE movieid=11768
-- 7
SELECT name FROM movie JOIN casting ON movie.id = movieid JOIN actor ON actorid = actor.id WHERE title = 'Alien'
-- 8
SELECT title FROM movie JOIN casting ON movie.id = movieid JOIN actor ON actorid = actor.id WHERE name = 'Harrison Ford'
-- 9
SELECT title FROM movie JOIN casting ON movie.id = movieid JOIN actor ON actorid = actor.id WHERE name = 'Harrison Ford' AND ord > 1
-- 10
SELECT title, name FROM movie JOIN casting ON movie.id = movieid JOIN actor ON actorid = actor.id WHERE yr = 1962 AND ord = 1
-- 11
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
-- 12
SELECT title, name FROM
  movie JOIN casting ON movie.id = movieid
        JOIN actor   ON actorid=actor.id
          WHERE movie.id IN (SELECT movieid FROM casting
                              WHERE actorid IN (
                                SELECT id FROM actor
                                WHERE name='Julie Andrews')) 
                AND ord = 1
-- 13
SELECT name FROM casting JOIN actor ON (actorid = actor.id AND ord = 1) GROUP BY name HAVING COUNT(*) >= 15
-- 14
SELECT title, COUNT(actorid) FROM movie JOIN casting ON movieid = movie.id WHERE yr = 1978 GROUP BY title ORDER BY COUNT(actorid) DESC, title
-- 15
SELECT name FROM casting JOIN actor ON actorid = actor.id WHERE name != 'Art Garfunkel' AND movieid IN (SELECT movieid FROM movie JOIN casting ON movie.id = movieid JOIN actor ON actorid = actor.id WHERE name = 'Art Garfunkel')

-- JOIN Quiz 
-- 1
SELECT name
  FROM actor INNER JOIN movie ON actor.id = director
 WHERE gross < budget
-- 2
SELECT *
  FROM actor JOIN casting ON actor.id = actorid
  JOIN movie ON movie.id = movieid
-- 3
SELECT name, COUNT(movieid)
  FROM casting JOIN actor ON actorid=actor.id
 WHERE name LIKE 'John %'
 GROUP BY name ORDER BY 2 DESC

-- 4
--Table-B
"Crocodile" Dundee
Crocodile Dundee in Los Angeles
Flipper
Lightning Jack

-- 5
SELECT name
  FROM movie JOIN casting ON movie.id = movieid
  JOIN actor ON actor.id = actorid
WHERE ord = 1 AND director = 351
-- 6
- link the director column in movies with the primary key in actor
- connect the primary keys of movie and actor via the casting table
-- 7
-- Table-B
A Bronx Tale	1993
Bang the Drum Slowly	1973
Limitless	2011

-- Nulls
-- 1
SELECT name FROM teacher WHERE dept IS NULL
-- 2
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
-- 3
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
-- 4
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)
-- 5
SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher
-- 6
SELECT teacher.name, COALESCE(dept.name, 'None') FROM teacher LEFT JOIN dept ON teacher.dept = dept.id
-- 7
SELECT COUNT(name), COUNT(mobile) FROM teacher
-- 8
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON teacher.dept = dept.id GROUP BY dept.name
-- 9
SELECT name, CASE WHEN dept IN (1, 2) THEN 'Sci' ELSE 'Art' END AS name FROM teacher
-- 10
SELECT name, 
        CASE 
          WHEN dept IN (1, 2) THEN 'Sci'
          WHEN dept = 3 THEN 'Art'
        ELSE 'None'
        END AS name 
          FROM teacher

-- Quiz 6
-- 1
SELECT teacher.name, dept.name FROM teacher LEFT OUTER JOIN dept ON (teacher.dept = dept.id)
-- 2
SELECT dept.name FROM teacher JOIN dept ON (dept.id = teacher.dept) WHERE teacher.name = 'Cutflower'
-- 3
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON dept.id = teacher.dept GROUP BY dept.name
-- 4
display 0 in result column for all teachers without department
-- 5
'four' for Throd
-- 6
-- Table-A
Shrivell	Computing
Throd	Computing
Splint	Computing
Spiregrain	Other
Cutflower	Other
Deadyawn	Other

-- SELF JOIN
-- 1
SELECT COUNT(*) FROM stops;
-- 2
SELECT id FROM stops WHERE name = 'Craiglockhart'
-- 3
SELECT id, name FROM stops JOIN route ON stop = id WHERE company = 'LRT' and num = '4'
-- 4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2
-- 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149
-- 6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'
-- 7
SELECT DISTINCT a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) WHERE a.stop=115 AND b.stop=137
-- 8
SELECT a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON a.stop=stopa.id JOIN stops stopb ON b.stop=stopb.id WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross'
-- 9
SELECT stopb.name, a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON stopa.id=a.stop JOIN stops stopb ON b.stop=stopb.id WHERE stopa.name='Craiglockhart'
-- 10
SELECT first.num, first.company, name, second.num, second.company FROM
(SELECT DISTINCT a.company, a.num, b.stop FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops ON a.stop=id WHERE name='Craiglockhart') AS first
JOIN
(SELECT DISTINCT a.company, a.num, b.stop FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops ON a.stop=id WHERE name='Lochend') AS second
ON first.stop=second.stop JOIN stops ON id=first.stop
ORDER BY first.num, first.company, name, second.num, second.company

-- Quiz 7
-- 1
SELECT DISTINCT a.name, b.name
  FROM stops a JOIN route z ON a.id=z.stop
  JOIN route y ON y.num = z.num
  JOIN stops b ON y.stop=b.id
 WHERE a.name='Craiglockhart' AND b.name ='Haymarket'
-- 2
SELECT S2.id, S2.name, R2.company, R2.num
  FROM stops S1, stops S2, route R1, route R2
 WHERE S1.name='Haymarket' AND S1.id=R1.stop
   AND R1.company=R2.company AND R1.num=R2.num
   AND R2.stop=S2.id AND R2.num='2A'
-- 3
SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.name='Tollcross'
