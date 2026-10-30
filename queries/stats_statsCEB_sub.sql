-- count: 79851
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE b.UserId= u.Id AND u.UpVotes>=0;

-- count: 10220614

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date<='2014-09-11 14:33:06'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=1 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-09-14 11:59:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, badges as b, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=17 AND b.Date<='2014-09-11 08:55:52'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND p.CommentCount<=18 AND p.CreationDate>='2010-07-23 07:27:31'::timestamp AND p.CreationDate<='2014-09-09 01:43:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.CommentCount<=18 AND p.CreationDate>='2010-07-23 07:27:31'::timestamp AND p.CreationDate<='2014-09-09 01:43:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND p.Id = pl.PostId AND p.OwnerUserId = u.Id AND p.CommentCount<=18 AND p.CreationDate>='2010-07-23 07:27:31'::timestamp AND p.CreationDate<='2014-09-09 01:43:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND p.CreationDate>='2010-09-06 00:58:21'::timestamp AND p.CreationDate<='2014-09-12 10:02:21'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-07-09 22:35:44'::timestamp AND p.CreationDate>='2010-09-06 00:58:21'::timestamp AND p.CreationDate<='2014-09-12 10:02:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND p.Id = pl.PostId AND p.OwnerUserId = u.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-07-09 22:35:44'::timestamp AND c.Score=0 AND p.CreationDate>='2010-09-06 00:58:21'::timestamp AND p.CreationDate<='2014-09-12 10:02:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.CommentCount>=0 AND p.CommentCount<=25;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.CommentCount>=0 AND p.CommentCount<=25;

-- count: 698213
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = ph.PostId AND p.CommentCount>=0 AND p.CommentCount<=25;

-- count: 780683

-- count: 780683
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, users as u WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND c.CreationDate>='2010-08-05 00:36:02'::timestamp AND c.CreationDate<='2014-09-08 16:50:49'::timestamp AND p.ViewCount>=0 AND p.ViewCount<=2897 AND p.CommentCount>=0 AND p.CommentCount<=16 AND p.FavoriteCount>=0 AND p.FavoriteCount<=10;

-- count: 326559

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND c.CreationDate>='2010-08-05 00:36:02'::timestamp AND c.CreationDate<='2014-09-08 16:50:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND p.ViewCount>=0 AND p.ViewCount<=2897 AND p.CommentCount>=0 AND p.CommentCount<=16 AND p.FavoriteCount>=0 AND p.FavoriteCount<=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND p.ViewCount>=0 AND p.ViewCount<=2897 AND p.CommentCount>=0 AND p.CommentCount<=16 AND p.FavoriteCount>=0 AND p.FavoriteCount<=10 AND c.CreationDate>='2010-08-05 00:36:02'::timestamp AND c.CreationDate<='2014-09-08 16:50:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND p.Score>=0 AND p.Score<=15 AND p.ViewCount>=0 AND p.ViewCount<=3002 AND p.AnswerCount<=3 AND p.CommentCount<=10 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-08-23 16:21:10'::timestamp AND u.CreationDate<='2014-09-02 09:50:06'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-08-23 16:21:10'::timestamp AND u.CreationDate<='2014-09-02 09:50:06'::timestamp AND p.Score>=0 AND p.Score<=15 AND p.ViewCount>=0 AND p.ViewCount<=3002 AND p.AnswerCount<=3 AND p.CommentCount<=10;

-- count: 326559
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, users as u WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND c.Score=0 AND p.Score>=0 AND p.Score<=15 AND p.ViewCount>=0 AND p.ViewCount<=3002 AND p.AnswerCount<=3 AND p.CommentCount<=10 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-08-23 16:21:10'::timestamp AND u.CreationDate<='2014-09-02 09:50:06'::timestamp;

-- count: 1018612

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=487 AND u.UpVotes<=27 AND u.CreationDate>='2010-10-22 22:40:35'::timestamp AND u.CreationDate<='2014-09-10 17:01:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=487 AND u.UpVotes<=27 AND u.CreationDate>='2010-10-22 22:40:35'::timestamp AND u.CreationDate<='2014-09-10 17:01:31'::timestamp;

-- count: 1018612
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, users as u WHERE u.Id = c.UserId AND c.UserId = ph.UserId AND u.Reputation>=1 AND u.Reputation<=487 AND u.UpVotes<=27 AND u.CreationDate>='2010-10-22 22:40:35'::timestamp AND u.CreationDate<='2014-09-10 17:01:31'::timestamp;

-- count: 315516

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.CreationDate>='2010-08-10 17:55:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Reputation>=1 AND u.Reputation<=691 AND c.CreationDate>='2010-08-10 17:55:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Reputation>=1 AND u.Reputation<=691;

-- count: 315516
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.CreationDate>='2010-08-10 17:55:45'::timestamp AND u.Reputation>=1 AND u.Reputation<=691;

-- count: 200

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.BountyAmount<=100 AND c.CreationDate>='2010-10-01 20:45:26'::timestamp AND c.CreationDate<='2014-09-05 12:51:17'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.UpVotes=0 AND u.CreationDate<='2014-09-12 03:25:34'::timestamp AND c.CreationDate>='2010-10-01 20:45:26'::timestamp AND c.CreationDate<='2014-09-05 12:51:17'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.UpVotes=0 AND u.CreationDate<='2014-09-12 03:25:34'::timestamp AND v.BountyAmount<=100;

-- count: 200
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.CreationDate>='2010-10-01 20:45:26'::timestamp AND c.CreationDate<='2014-09-05 12:51:17'::timestamp AND v.BountyAmount<=100 AND u.UpVotes=0 AND u.CreationDate<='2014-09-12 03:25:34'::timestamp;

-- count: 10223864

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-07-19 20:34:06'::timestamp AND b.Date<='2014-09-12 15:11:36'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-24 06:46:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.UpVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-07-24 06:46:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.UpVotes>=0 AND b.Date>='2010-07-19 20:34:06'::timestamp AND b.Date<='2014-09-12 15:11:36'::timestamp;

-- count: 10223864
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, badges as b, users as u WHERE u.Id = c.UserId AND c.UserId = b.UserId AND c.Score=0 AND c.CreationDate>='2010-07-24 06:46:49'::timestamp AND b.Date>='2010-07-19 20:34:06'::timestamp AND b.Date<='2014-09-12 15:11:36'::timestamp AND u.UpVotes>=0;

-- count: 245567

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-07-19 20:54:06'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=17 AND u.CreationDate>='2010-08-06 07:03:05'::timestamp AND u.CreationDate<='2014-09-08 04:18:44'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=17 AND u.CreationDate>='2010-08-06 07:03:05'::timestamp AND u.CreationDate<='2014-09-08 04:18:44'::timestamp AND b.Date>='2010-07-19 20:54:06'::timestamp;

-- count: 245567
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, badges as b, users as u WHERE u.Id = c.UserId AND c.UserId = b.UserId AND c.Score=0 AND b.Date>='2010-07-19 20:54:06'::timestamp AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=17 AND u.CreationDate>='2010-08-06 07:03:05'::timestamp AND u.CreationDate<='2014-09-08 04:18:44'::timestamp;

-- count: 70752

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM tags as t, posts as p WHERE p.Id = t.ExcerptPostId AND p.CreationDate>='2010-07-20 02:01:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND p.CreationDate>='2010-07-20 02:01:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, tags as t, users as u WHERE p.Id = t.ExcerptPostId AND v.UserId = u.Id AND p.OwnerUserId = u.Id AND p.CreationDate>='2010-07-20 02:01:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE pl.PostId = p.Id AND p.CreationDate>='2010-07-19 20:08:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE ph.PostId = p.Id AND ph.CreationDate>='2010-07-20 00:30:00'::timestamp AND p.CreationDate>='2010-07-19 20:08:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2010-07-20 00:30:00'::timestamp;

-- count: 63500
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND pl.PostId = ph.PostId AND p.CreationDate>='2010-07-19 20:08:37'::timestamp AND ph.CreationDate>='2010-07-20 00:30:00'::timestamp;

-- count: 10895

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.CommentCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.CreationDate<='2014-09-12 07:12:16'::timestamp AND p.CommentCount<=17;

-- count: 10895
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, users as u WHERE p.Id = pl.PostId AND p.OwnerUserId = u.Id AND p.CommentCount<=17 AND u.CreationDate<='2014-09-12 07:12:16'::timestamp;

-- count: 251068

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE ph.PostId = p.Id AND p.CreationDate>='2010-07-26 19:26:37'::timestamp AND p.CreationDate<='2014-08-22 14:43:39'::timestamp AND ph.CreationDate<='2014-08-17 21:24:11'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Reputation>=1 AND u.Reputation<=6524 AND u.Views>=0 AND p.CreationDate>='2010-07-26 19:26:37'::timestamp AND p.CreationDate<='2014-08-22 14:43:39'::timestamp;

-- count: 251068
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE ph.PostId = p.Id AND p.OwnerUserId = u.Id AND ph.CreationDate<='2014-08-17 21:24:11'::timestamp AND p.CreationDate>='2010-07-26 19:26:37'::timestamp AND p.CreationDate<='2014-08-22 14:43:39'::timestamp AND u.Reputation>=1 AND u.Reputation<=6524 AND u.Views>=0;

-- count: 26836

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE v.PostId = p.Id AND p.Score>=-1 AND p.CreationDate>='2010-10-21 13:21:24'::timestamp AND p.CreationDate<='2014-09-09 15:12:22'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.UpVotes>=0 AND u.CreationDate>='2010-07-27 17:15:57'::timestamp AND u.CreationDate<='2014-09-03 12:47:42'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

-- count: 26836
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE v.PostId = p.Id AND v.UserId = u.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.Score>=-1 AND p.CreationDate>='2010-10-21 13:21:24'::timestamp AND p.CreationDate<='2014-09-09 15:12:22'::timestamp AND u.UpVotes>=0 AND u.CreationDate>='2010-07-27 17:15:57'::timestamp AND u.CreationDate<='2014-09-03 12:47:42'::timestamp;

-- count: 2488080

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.CreationDate>='2010-07-22 04:38:06'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.CreationDate>='2010-07-22 04:38:06'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=12;

-- count: 2488080
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE v.UserId = p.OwnerUserId AND p.OwnerUserId = u.Id AND p.CommentCount>=0 AND p.CommentCount<=12 AND u.CreationDate>='2010-07-22 04:38:06'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp;

-- count: 144017

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE v.UserId = u.Id AND b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0;

-- count: 144017
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, badges as b, users as u WHERE u.Id = v.UserId AND v.UserId = b.UserId AND u.DownVotes>=0 AND u.DownVotes<=0;

-- count: 4582

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE v.UserId = u.Id AND b.UserId = u.Id AND v.BountyAmount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.DownVotes=0 AND v.BountyAmount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.DownVotes=0;

-- count: 4582
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, badges as b, users as u WHERE u.Id = v.UserId AND v.UserId = b.UserId AND v.BountyAmount>=0 AND v.BountyAmount<=50 AND u.DownVotes=0;

-- count: 176191

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id AND p.Score>=-3 AND c.CreationDate>='2010-08-02 23:52:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND c.CreationDate>='2010-08-02 23:52:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.CreationDate>='2010-08-02 23:52:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE pl.PostId = p.Id AND p.Score>=-3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE v.PostId = p.Id AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.Score>=-3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND c.CreationDate>='2010-08-02 23:52:10'::timestamp AND p.Score>=-3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.CreationDate>='2010-08-02 23:52:10'::timestamp AND p.Score>=-3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.CreationDate>='2010-08-02 23:52:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE pl.PostId = p.Id AND v.PostId = p.Id AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.Score>=-3;

-- count: 176191
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = c.PostId AND c.PostId = pl.PostId AND pl.PostId = v.PostId AND c.CreationDate>='2010-08-02 23:52:10'::timestamp AND p.Score>=-3 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

-- count: 25033

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND c.CreationDate>='2010-07-21 11:05:37'::timestamp AND c.CreationDate<='2014-08-25 17:59:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-21 11:05:37'::timestamp AND c.CreationDate<='2014-08-25 17:59:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.UpVotes>=0 AND u.CreationDate>='2010-08-21 21:27:38'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-21 11:05:37'::timestamp AND c.CreationDate<='2014-08-25 17:59:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE p.OwnerUserId = u.Id AND p.Id = c.PostId AND u.UpVotes>=0 AND u.CreationDate>='2010-08-21 21:27:38'::timestamp AND c.CreationDate>='2010-07-21 11:05:37'::timestamp AND c.CreationDate<='2014-08-25 17:59:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE p.OwnerUserId = u.Id AND p.Id = pl.RelatedPostId AND u.UpVotes>=0 AND u.CreationDate>='2010-08-21 21:27:38'::timestamp;

-- count: 25033
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, users as u WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.OwnerUserId = u.Id AND c.CreationDate>='2010-07-21 11:05:37'::timestamp AND c.CreationDate<='2014-08-25 17:59:25'::timestamp AND u.UpVotes>=0 AND u.CreationDate>='2010-08-21 21:27:38'::timestamp;

-- count: 42036

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.CreationDate>='2010-07-27 01:51:15'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-13 20:12:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.BountyAmount<=50 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-13 20:12:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.UpVotes>=0 AND u.UpVotes<=12 AND u.CreationDate>='2010-07-19 19:09:39'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-13 20:12:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.BountyAmount<=50 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.CreationDate>='2010-07-27 01:51:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.UpVotes>=0 AND u.UpVotes<=12 AND u.CreationDate>='2010-07-19 19:09:39'::timestamp AND p.CreationDate>='2010-07-27 01:51:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.UpVotes>=0 AND u.UpVotes<=12 AND u.CreationDate>='2010-07-19 19:09:39'::timestamp AND v.BountyAmount<=50 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Id = p.OwnerUserId AND v.BountyAmount<=50 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND p.CreationDate>='2010-07-27 01:51:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.UpVotes>=0 AND u.UpVotes<=12 AND u.CreationDate>='2010-07-19 19:09:39'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND p.CreationDate>='2010-07-27 01:51:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.UpVotes>=0 AND u.UpVotes<=12 AND u.CreationDate>='2010-07-19 19:09:39'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND v.BountyAmount<=50 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.UpVotes>=0 AND u.UpVotes<=12 AND u.CreationDate>='2010-07-19 19:09:39'::timestamp AND p.CreationDate>='2010-07-27 01:51:15'::timestamp AND v.BountyAmount<=50 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

-- count: 42036
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND p.CreationDate>='2010-07-27 01:51:15'::timestamp AND v.BountyAmount<=50 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND u.UpVotes>=0 AND u.UpVotes<=12 AND u.CreationDate>='2010-07-19 19:09:39'::timestamp;

-- count: 16049150

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE p.Id = v.PostId AND p.Score<=22;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score<=22;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND p.Score<=22;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Score<=22;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation>=1 AND p.Score<=22;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation>=1 AND p.Score<=22;

-- count: 16049150
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, badges as b, users as u WHERE p.Id = v.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score<=22 AND u.Reputation>=1;

-- count: 595820

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE p.Id = v.PostId AND p.PostTypeId=1 AND p.Score>=-1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=20 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date>='2010-07-20 19:02:22'::timestamp AND b.Date<='2014-09-03 23:36:09'::timestamp AND p.PostTypeId=1 AND p.Score>=-1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=20;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes<=2 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-26 03:34:11'::timestamp AND p.PostTypeId=1 AND p.Score>=-1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=20;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.DownVotes<=2 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-26 03:34:11'::timestamp AND b.Date>='2010-07-20 19:02:22'::timestamp AND b.Date<='2014-09-03 23:36:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND b.Date>='2010-07-20 19:02:22'::timestamp AND b.Date<='2014-09-03 23:36:09'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.PostTypeId=1 AND p.Score>=-1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=20;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes<=2 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-26 03:34:11'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.PostTypeId=1 AND p.Score>=-1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=20;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.DownVotes<=2 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-26 03:34:11'::timestamp AND p.PostTypeId=1 AND p.Score>=-1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=20 AND b.Date>='2010-07-20 19:02:22'::timestamp AND b.Date<='2014-09-03 23:36:09'::timestamp;

-- count: 595820
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, badges as b, users as u WHERE p.Id = v.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.PostTypeId=1 AND p.Score>=-1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=20 AND b.Date>='2010-07-20 19:02:22'::timestamp AND b.Date<='2014-09-03 23:36:09'::timestamp AND u.DownVotes<=2 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-26 03:34:11'::timestamp;

-- count: 232039659

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.Score>=0 AND p.Score<=30 AND p.CommentCount=0 AND p.CreationDate>='2010-07-27 15:30:31'::timestamp AND p.CreationDate<='2014-09-04 17:45:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=0 AND p.Score<=30 AND p.CommentCount=0 AND p.CreationDate>='2010-07-27 15:30:31'::timestamp AND p.CreationDate<='2014-09-04 17:45:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND p.Score>=0 AND p.Score<=30 AND p.CommentCount=0 AND p.CreationDate>='2010-07-27 15:30:31'::timestamp AND p.CreationDate<='2014-09-04 17:45:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId;

-- count: 232039659
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, badges as b, users as u WHERE u.Id = v.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=0 AND p.Score<=30 AND p.CommentCount=0 AND p.CreationDate>='2010-07-27 15:30:31'::timestamp AND p.CreationDate<='2014-09-04 17:45:10'::timestamp;

-- count: 6672465

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.Score>=0 AND p.Score<=30 AND p.CommentCount=0 AND p.CreationDate>='2010-07-27 15:30:31'::timestamp AND p.CreationDate<='2014-09-04 17:45:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=0 AND p.Score<=30 AND p.CommentCount=0 AND p.CreationDate>='2010-07-27 15:30:31'::timestamp AND p.CreationDate<='2014-09-04 17:45:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND p.Score>=0 AND p.Score<=30 AND p.CommentCount=0 AND p.CreationDate>='2010-07-27 15:30:31'::timestamp AND p.CreationDate<='2014-09-04 17:45:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.Score<=48 AND p.AnswerCount<=8 AND v.CreationDate<='2014-09-06 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date>='2011-01-03 20:50:19'::timestamp AND b.Date<='2014-09-02 15:35:07'::timestamp AND v.CreationDate<='2014-09-06 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.CreationDate>='2010-11-16 06:03:04'::timestamp AND v.CreationDate<='2014-09-06 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date>='2011-01-03 20:50:19'::timestamp AND b.Date<='2014-09-02 15:35:07'::timestamp AND p.Score<=48 AND p.AnswerCount<=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.CreationDate>='2010-11-16 06:03:04'::timestamp AND p.Score<=48 AND p.AnswerCount<=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.CreationDate>='2010-11-16 06:03:04'::timestamp AND b.Date>='2011-01-03 20:50:19'::timestamp AND b.Date<='2014-09-02 15:35:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date>='2011-01-03 20:50:19'::timestamp AND b.Date<='2014-09-02 15:35:07'::timestamp AND v.CreationDate<='2014-09-06 00:00:00'::timestamp AND p.Score<=48 AND p.AnswerCount<=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.CreationDate>='2010-11-16 06:03:04'::timestamp AND v.CreationDate<='2014-09-06 00:00:00'::timestamp AND p.Score<=48 AND p.AnswerCount<=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-11-16 06:03:04'::timestamp AND v.CreationDate<='2014-09-06 00:00:00'::timestamp AND b.Date>='2011-01-03 20:50:19'::timestamp AND b.Date<='2014-09-02 15:35:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.CreationDate>='2010-11-16 06:03:04'::timestamp AND p.Score<=48 AND p.AnswerCount<=8 AND b.Date>='2011-01-03 20:50:19'::timestamp AND b.Date<='2014-09-02 15:35:07'::timestamp;

-- count: 6672465
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, badges as b, users as u WHERE u.Id = v.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND v.CreationDate<='2014-09-06 00:00:00'::timestamp AND p.Score<=48 AND p.AnswerCount<=8 AND b.Date>='2011-01-03 20:50:19'::timestamp AND b.Date<='2014-09-02 15:35:07'::timestamp AND u.CreationDate>='2010-11-16 06:03:04'::timestamp;

-- count: 19402569

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2011-04-11 14:46:09'::timestamp AND ph.CreationDate<='2014-08-17 16:37:23'::timestamp AND c.CreationDate>='2010-08-12 20:33:46'::timestamp AND c.CreationDate<='2014-09-13 19:26:55'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.CreationDate>='2010-08-12 20:33:46'::timestamp AND c.CreationDate<='2014-09-13 19:26:55'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Views>=0 AND u.Views<=783 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-12 20:33:46'::timestamp AND c.CreationDate<='2014-09-13 19:26:55'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND ph.CreationDate>='2011-04-11 14:46:09'::timestamp AND ph.CreationDate<='2014-08-17 16:37:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Views>=0 AND u.Views<=783 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=123 AND ph.CreationDate>='2011-04-11 14:46:09'::timestamp AND ph.CreationDate<='2014-08-17 16:37:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.Views>=0 AND u.Views<=783 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=123 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=783 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-12 20:33:46'::timestamp AND c.CreationDate<='2014-09-13 19:26:55'::timestamp AND ph.CreationDate>='2011-04-11 14:46:09'::timestamp AND ph.CreationDate<='2014-08-17 16:37:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.Views>=0 AND u.Views<=783 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-12 20:33:46'::timestamp AND c.CreationDate<='2014-09-13 19:26:55'::timestamp AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=783 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=123 AND ph.CreationDate>='2011-04-11 14:46:09'::timestamp AND ph.CreationDate<='2014-08-17 16:37:23'::timestamp AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

-- count: 19402569
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, votes as v, users as u WHERE u.Id = v.UserId AND v.UserId = ph.UserId AND ph.UserId =c.UserId AND c.CreationDate>='2010-08-12 20:33:46'::timestamp AND c.CreationDate<='2014-09-13 19:26:55'::timestamp AND ph.CreationDate>='2011-04-11 14:46:09'::timestamp AND ph.CreationDate<='2014-08-17 16:37:23'::timestamp AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND u.Views>=0 AND u.Views<=783 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=123;

-- count: 6299

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-08 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.Views<=110 AND u.UpVotes=0 AND u.CreationDate>='2010-07-28 19:29:11'::timestamp AND u.CreationDate<='2014-08-14 05:29:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-08 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.Views<=110 AND u.UpVotes=0 AND u.CreationDate>='2010-07-28 19:29:11'::timestamp AND u.CreationDate<='2014-08-14 05:29:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.Views<=110 AND u.UpVotes=0 AND u.CreationDate>='2010-07-28 19:29:11'::timestamp AND u.CreationDate<='2014-08-14 05:29:30'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-08 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.Views<=110 AND u.UpVotes=0 AND u.CreationDate>='2010-07-28 19:29:11'::timestamp AND u.CreationDate<='2014-08-14 05:29:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.Views<=110 AND u.UpVotes=0 AND u.CreationDate>='2010-07-28 19:29:11'::timestamp AND u.CreationDate<='2014-08-14 05:29:30'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-08 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.Views<=110 AND u.UpVotes=0 AND u.CreationDate>='2010-07-28 19:29:11'::timestamp AND u.CreationDate<='2014-08-14 05:29:30'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-08 00:00:00'::timestamp;

-- count: 6299
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, votes as v, users as u WHERE u.Id = v.UserId AND v.UserId = ph.UserId AND ph.UserId =c.UserId AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-08 00:00:00'::timestamp AND u.Reputation>=1 AND u.Views>=0 AND u.Views<=110 AND u.UpVotes=0 AND u.CreationDate>='2010-07-28 19:29:11'::timestamp AND u.CreationDate<='2014-08-14 05:29:30'::timestamp;

-- count: 593169291

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp;

-- count: 593169291
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, badges as b, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Id = b.UserId AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp AND u.CreationDate>='2010-07-20 01:27:29'::timestamp;

-- count: 3169724

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.BountyAmount>=0 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.DownVotes<=57 AND u.CreationDate>='2010-08-26 09:01:31'::timestamp AND u.CreationDate<='2014-08-10 11:01:39'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND v.BountyAmount>=0 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.DownVotes<=57 AND u.CreationDate>='2010-08-26 09:01:31'::timestamp AND u.CreationDate<='2014-08-10 11:01:39'::timestamp AND v.BountyAmount>=0 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.DownVotes<=57 AND u.CreationDate>='2010-08-26 09:01:31'::timestamp AND u.CreationDate<='2014-08-10 11:01:39'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND c.Score=0 AND v.BountyAmount>=0 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.DownVotes<=57 AND u.CreationDate>='2010-08-26 09:01:31'::timestamp AND u.CreationDate<='2014-08-10 11:01:39'::timestamp AND c.Score=0 AND v.BountyAmount>=0 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.DownVotes<=57 AND u.CreationDate>='2010-08-26 09:01:31'::timestamp AND u.CreationDate<='2014-08-10 11:01:39'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.DownVotes<=57 AND u.CreationDate>='2010-08-26 09:01:31'::timestamp AND u.CreationDate<='2014-08-10 11:01:39'::timestamp AND v.BountyAmount>=0 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

-- count: 3169724
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, badges as b, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Id = b.UserId AND c.Score=0 AND v.BountyAmount>=0 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND u.DownVotes<=57 AND u.CreationDate>='2010-08-26 09:01:31'::timestamp AND u.CreationDate<='2014-08-10 11:01:39'::timestamp;

-- count: 52313

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.BountyAmount>=0 AND v.BountyAmount<=300 AND v.CreationDate>='2010-07-29 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.UpVotes>=0 AND u.UpVotes<=18 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND v.BountyAmount>=0 AND v.BountyAmount<=300 AND v.CreationDate>='2010-07-29 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.UpVotes>=0 AND u.UpVotes<=18 AND v.BountyAmount>=0 AND v.BountyAmount<=300 AND v.CreationDate>='2010-07-29 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.UpVotes>=0 AND u.UpVotes<=18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND c.Score=0 AND v.BountyAmount>=0 AND v.BountyAmount<=300 AND v.CreationDate>='2010-07-29 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.UpVotes>=0 AND u.UpVotes<=18 AND c.Score=0 AND v.BountyAmount>=0 AND v.BountyAmount<=300 AND v.CreationDate>='2010-07-29 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.UpVotes>=0 AND u.UpVotes<=18 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.UpVotes>=0 AND u.UpVotes<=18 AND v.BountyAmount>=0 AND v.BountyAmount<=300 AND v.CreationDate>='2010-07-29 00:00:00'::timestamp;

-- count: 52313
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, badges as b, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Id = b.UserId AND c.Score=0 AND v.BountyAmount>=0 AND v.BountyAmount<=300 AND v.CreationDate>='2010-07-29 00:00:00'::timestamp AND u.UpVotes>=0 AND u.UpVotes<=18;

-- count: 1633681

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2011-05-07 21:47:19'::timestamp AND ph.CreationDate<='2014-09-10 13:19:54'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2011-05-07 21:47:19'::timestamp AND ph.CreationDate<='2014-09-10 13:19:54'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE v.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2011-05-07 21:47:19'::timestamp AND ph.CreationDate<='2014-09-10 13:19:54'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2011-05-07 21:47:19'::timestamp AND ph.CreationDate<='2014-09-10 13:19:54'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND ph.CreationDate>='2011-05-07 21:47:19'::timestamp AND ph.CreationDate<='2014-09-10 13:19:54'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2011-05-07 21:47:19'::timestamp AND ph.CreationDate<='2014-09-10 13:19:54'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND ph.CreationDate>='2011-05-07 21:47:19'::timestamp AND ph.CreationDate<='2014-09-10 13:19:54'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-07-26 20:01:58'::timestamp AND ph.CreationDate<='2014-09-13 17:29:23'::timestamp AND c.Score=0 AND c.CreationDate>='2010-09-05 16:04:35'::timestamp AND c.CreationDate<='2014-09-11 04:35:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND b.Date<='2014-09-04 08:54:56'::timestamp AND c.Score=0 AND c.CreationDate>='2010-09-05 16:04:35'::timestamp AND c.CreationDate<='2014-09-11 04:35:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND c.Score=0 AND c.CreationDate>='2010-09-05 16:04:35'::timestamp AND c.CreationDate<='2014-09-11 04:35:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-04 08:54:56'::timestamp AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-07-26 20:01:58'::timestamp AND ph.CreationDate<='2014-09-13 17:29:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-07-26 20:01:58'::timestamp AND ph.CreationDate<='2014-09-13 17:29:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND b.Date<='2014-09-04 08:54:56'::timestamp;

-- count: 105742741
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, badges as b, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Id = b.UserId AND c.Score=0 AND c.CreationDate>='2010-09-05 16:04:35'::timestamp AND c.CreationDate<='2014-09-11 04:35:36'::timestamp AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-07-26 20:01:58'::timestamp AND ph.CreationDate<='2014-09-13 17:29:23'::timestamp AND b.Date<='2014-09-04 08:54:56'::timestamp;

-- count: 2034610

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND c.Score=0 AND c.CreationDate>='2010-09-05 16:04:35'::timestamp AND c.CreationDate<='2014-09-11 04:35:36'::timestamp AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-07-26 20:01:58'::timestamp AND ph.CreationDate<='2014-09-13 17:29:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=0 AND c.CreationDate>='2010-09-05 16:04:35'::timestamp AND c.CreationDate<='2014-09-11 04:35:36'::timestamp AND b.Date<='2014-09-04 08:54:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-07-26 20:01:58'::timestamp AND ph.CreationDate<='2014-09-13 17:29:23'::timestamp AND b.Date<='2014-09-04 08:54:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-04 08:54:56'::timestamp AND c.Score=0 AND c.CreationDate>='2010-09-05 16:04:35'::timestamp AND c.CreationDate<='2014-09-11 04:35:36'::timestamp AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-07-26 20:01:58'::timestamp AND ph.CreationDate<='2014-09-13 17:29:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=5 AND ph.CreationDate>='2011-01-31 15:35:37'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 10:52:57'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 10:52:57'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Reputation>=1 AND u.Reputation<=356 AND u.DownVotes<=34 AND u.CreationDate>='2010-07-19 21:29:29'::timestamp AND u.CreationDate<='2014-08-20 14:31:46'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 10:52:57'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=5 AND ph.CreationDate>='2011-01-31 15:35:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=356 AND u.DownVotes<=34 AND u.CreationDate>='2010-07-19 21:29:29'::timestamp AND u.CreationDate<='2014-08-20 14:31:46'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate>='2011-01-31 15:35:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND u.Reputation<=356 AND u.DownVotes<=34 AND u.CreationDate>='2010-07-19 21:29:29'::timestamp AND u.CreationDate<='2014-08-20 14:31:46'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=356 AND u.DownVotes<=34 AND u.CreationDate>='2010-07-19 21:29:29'::timestamp AND u.CreationDate<='2014-08-20 14:31:46'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 10:52:57'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate>='2011-01-31 15:35:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.Reputation<=356 AND u.DownVotes<=34 AND u.CreationDate>='2010-07-19 21:29:29'::timestamp AND u.CreationDate<='2014-08-20 14:31:46'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 10:52:57'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=356 AND u.DownVotes<=34 AND u.CreationDate>='2010-07-19 21:29:29'::timestamp AND u.CreationDate<='2014-08-20 14:31:46'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate>='2011-01-31 15:35:37'::timestamp;

-- count: 2034610
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, badges as b, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Id = b.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 10:52:57'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate>='2011-01-31 15:35:37'::timestamp AND u.Reputation>=1 AND u.Reputation<=356 AND u.DownVotes<=34 AND u.CreationDate>='2010-07-19 21:29:29'::timestamp AND u.CreationDate<='2014-08-20 14:31:46'::timestamp;

-- count: 28565

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Score>=-1 AND p.CommentCount<=8 AND p.CreationDate>='2010-07-21 12:30:43'::timestamp AND p.CreationDate<='2014-09-07 01:11:03'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views<=40 AND u.CreationDate>='2010-07-26 19:11:25'::timestamp AND u.CreationDate<='2014-09-11 22:26:42'::timestamp AND p.Score>=-1 AND p.CommentCount<=8 AND p.CreationDate>='2010-07-21 12:30:43'::timestamp AND p.CreationDate<='2014-09-07 01:11:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=-1 AND p.CommentCount<=8 AND p.CreationDate>='2010-07-21 12:30:43'::timestamp AND p.CreationDate<='2014-09-07 01:11:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND u.Views<=40 AND u.CreationDate>='2010-07-26 19:11:25'::timestamp AND u.CreationDate<='2014-09-11 22:26:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postLinks as pl, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Views<=40 AND u.CreationDate>='2010-07-26 19:11:25'::timestamp AND u.CreationDate<='2014-09-11 22:26:42'::timestamp AND pl.LinkTypeId=1 AND p.Score>=-1 AND p.CommentCount<=8 AND p.CreationDate>='2010-07-21 12:30:43'::timestamp AND p.CreationDate<='2014-09-07 01:11:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND pl.LinkTypeId=1 AND p.Score>=-1 AND p.CommentCount<=8 AND p.CreationDate>='2010-07-21 12:30:43'::timestamp AND p.CreationDate<='2014-09-07 01:11:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=-1 AND p.CommentCount<=8 AND p.CreationDate>='2010-07-21 12:30:43'::timestamp AND p.CreationDate<='2014-09-07 01:11:03'::timestamp AND u.Views<=40 AND u.CreationDate>='2010-07-26 19:11:25'::timestamp AND u.CreationDate<='2014-09-11 22:26:42'::timestamp;

-- count: 28565
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p, users as u, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND pl.LinkTypeId=1 AND p.Score>=-1 AND p.CommentCount<=8 AND p.CreationDate>='2010-07-21 12:30:43'::timestamp AND p.CreationDate<='2014-09-07 01:11:03'::timestamp AND u.Views<=40 AND u.CreationDate>='2010-07-26 19:11:25'::timestamp AND u.CreationDate<='2014-09-11 22:26:42'::timestamp;

-- count: 1717

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Score>=-1 AND p.Score<=10 AND p.AnswerCount<=5 AND p.CommentCount=2 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND pl.CreationDate<='2014-08-17 01:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views<=33 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-19 17:31:36'::timestamp AND u.CreationDate<='2014-08-06 07:23:12'::timestamp AND p.Score>=-1 AND p.Score<=10 AND p.AnswerCount<=5 AND p.CommentCount=2 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-10 22:50:06'::timestamp AND p.Score>=-1 AND p.Score<=10 AND p.AnswerCount<=5 AND p.CommentCount=2 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND b.Date<='2014-09-10 22:50:06'::timestamp AND u.Views<=33 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-19 17:31:36'::timestamp AND u.CreationDate<='2014-08-06 07:23:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postLinks as pl, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Views<=33 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-19 17:31:36'::timestamp AND u.CreationDate<='2014-08-06 07:23:12'::timestamp AND pl.CreationDate<='2014-08-17 01:23:50'::timestamp AND p.Score>=-1 AND p.Score<=10 AND p.AnswerCount<=5 AND p.CommentCount=2 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND b.Date<='2014-09-10 22:50:06'::timestamp AND pl.CreationDate<='2014-08-17 01:23:50'::timestamp AND p.Score>=-1 AND p.Score<=10 AND p.AnswerCount<=5 AND p.CommentCount=2 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-10 22:50:06'::timestamp AND p.Score>=-1 AND p.Score<=10 AND p.AnswerCount<=5 AND p.CommentCount=2 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND u.Views<=33 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-19 17:31:36'::timestamp AND u.CreationDate<='2014-08-06 07:23:12'::timestamp;

-- count: 1717
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p, users as u, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND pl.CreationDate<='2014-08-17 01:23:50'::timestamp AND p.Score>=-1 AND p.Score<=10 AND p.AnswerCount<=5 AND p.CommentCount=2 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND u.Views<=33 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-19 17:31:36'::timestamp AND u.CreationDate<='2014-08-06 07:23:12'::timestamp AND b.Date<='2014-09-10 22:50:06'::timestamp;

-- count: 896180

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.PostTypeId=1 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=11;

-- count: 896180
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, votes as v, users as u WHERE p.Id = ph.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=11;

-- count: 7661811

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.Score>=-7 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation>=1 AND u.UpVotes>=0 AND u.UpVotes<=117 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Reputation>=1 AND u.UpVotes>=0 AND u.UpVotes<=117 AND p.Score>=-7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.Score>=-7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE b.UserId = u.Id AND u.Reputation>=1 AND u.UpVotes>=0 AND u.UpVotes<=117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.UpVotes>=0 AND u.UpVotes<=117 AND ph.PostHistoryTypeId=3 AND p.Score>=-7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=3 AND p.Score>=-7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=3 AND u.Reputation>=1 AND u.UpVotes>=0 AND u.UpVotes<=117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.Score>=-7 AND u.Reputation>=1 AND u.UpVotes>=0 AND u.UpVotes<=117;

-- count: 7661811
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u, badges as b WHERE u.Id = p.OwnerUserId AND p.OwnerUserId = ph.UserId AND ph.UserId = b.UserId AND ph.PostHistoryTypeId=3 AND p.Score>=-7 AND u.Reputation>=1 AND u.UpVotes>=0 AND u.UpVotes<=117;

-- count: 2101105

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.Score>=-1 AND p.ViewCount>=0 AND p.ViewCount<=39097 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=10 AND p.CreationDate>='2010-08-13 02:18:09'::timestamp AND p.CreationDate<='2014-09-09 10:20:27'::timestamp AND ph.CreationDate>='2010-09-06 11:41:43'::timestamp AND ph.CreationDate<='2014-09-03 16:41:18'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=37 AND ph.CreationDate>='2010-09-06 11:41:43'::timestamp AND ph.CreationDate<='2014-09-03 16:41:18'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-09-06 11:41:43'::timestamp AND ph.CreationDate<='2014-09-03 16:41:18'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=37 AND p.Score>=-1 AND p.ViewCount>=0 AND p.ViewCount<=39097 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=10 AND p.CreationDate>='2010-08-13 02:18:09'::timestamp AND p.CreationDate<='2014-09-09 10:20:27'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.Score>=-1 AND p.ViewCount>=0 AND p.ViewCount<=39097 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=10 AND p.CreationDate>='2010-08-13 02:18:09'::timestamp AND p.CreationDate<='2014-09-09 10:20:27'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE b.UserId = u.Id AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=37;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=37 AND ph.CreationDate>='2010-09-06 11:41:43'::timestamp AND ph.CreationDate<='2014-09-03 16:41:18'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.ViewCount<=39097 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=10 AND p.CreationDate>='2010-08-13 02:18:09'::timestamp AND p.CreationDate<='2014-09-09 10:20:27'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-09-06 11:41:43'::timestamp AND ph.CreationDate<='2014-09-03 16:41:18'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.ViewCount<=39097 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=10 AND p.CreationDate>='2010-08-13 02:18:09'::timestamp AND p.CreationDate<='2014-09-09 10:20:27'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-09-06 11:41:43'::timestamp AND ph.CreationDate<='2014-09-03 16:41:18'::timestamp AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=37;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.Score>=-1 AND p.ViewCount>=0 AND p.ViewCount<=39097 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=10 AND p.CreationDate>='2010-08-13 02:18:09'::timestamp AND p.CreationDate<='2014-09-09 10:20:27'::timestamp AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=37;

-- count: 2101105
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u, badges as b WHERE u.Id = p.OwnerUserId AND p.OwnerUserId = ph.UserId AND ph.UserId = b.UserId AND ph.CreationDate>='2010-09-06 11:41:43'::timestamp AND ph.CreationDate<='2014-09-03 16:41:18'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.ViewCount<=39097 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=10 AND p.CreationDate>='2010-08-13 02:18:09'::timestamp AND p.CreationDate<='2014-09-09 10:20:27'::timestamp AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=37;

-- count: 6272

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE u.Id = v.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Views=5 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=224 AND u.CreationDate<='2014-09-04 04:41:22'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-19 19:39:10'::timestamp AND b.Date<='2014-09-05 18:37:48'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Views=5 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=224 AND u.CreationDate<='2014-09-04 04:41:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date>='2010-07-19 19:39:10'::timestamp AND b.Date<='2014-09-05 18:37:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND b.Date>='2010-07-19 19:39:10'::timestamp AND b.Date<='2014-09-05 18:37:48'::timestamp AND u.Views=5 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=224 AND u.CreationDate<='2014-09-04 04:41:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE u.Id = v.UserId AND u.Id = ph.UserId AND u.Views=5 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=224 AND u.CreationDate<='2014-09-04 04:41:22'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-19 19:39:10'::timestamp AND b.Date<='2014-09-05 18:37:48'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-19 19:39:10'::timestamp AND b.Date<='2014-09-05 18:37:48'::timestamp AND ph.PostHistoryTypeId=2 AND u.Views=5 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=224 AND u.CreationDate<='2014-09-04 04:41:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date>='2010-07-19 19:39:10'::timestamp AND b.Date<='2014-09-05 18:37:48'::timestamp AND u.Views=5 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=224 AND u.CreationDate<='2014-09-04 04:41:22'::timestamp;

-- count: 6272
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, votes as v, users as u, badges as b WHERE u.Id = ph.UserId AND u.Id = v.UserId AND u.Id = b.UserId AND ph.PostHistoryTypeId=2 AND u.Views=5 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=224 AND u.CreationDate<='2014-09-04 04:41:22'::timestamp AND b.Date>='2010-07-19 19:39:10'::timestamp AND b.Date<='2014-09-05 18:37:48'::timestamp;

-- count: 454094

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

-- count: 454094
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

-- count: 60601561

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=3 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND v.BountyAmount<=50 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.DownVotes>=0 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount<=50 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.DownVotes>=0 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.DownVotes>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=3 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount<=50 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND u.DownVotes>=0 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount<=50 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.DownVotes>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount<=50 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND u.DownVotes>=0 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND ph.PostHistoryTypeId=3 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount<=50 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND u.DownVotes>=0 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND ph.UserId = u.Id AND v.UserId = u.Id AND u.DownVotes>=0 AND ph.PostHistoryTypeId=3 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=3 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=12 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.CreationDate>='2010-07-20 21:37:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND c.CreationDate>='2010-07-20 21:37:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.UpVotes=0 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.UpVotes=0 AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, badges as b, users as u WHERE b.UserId = u.Id AND v.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.UpVotes=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.UpVotes=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND c.CreationDate>='2010-07-20 21:37:31'::timestamp AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND c.CreationDate>='2010-07-20 21:37:31'::timestamp AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes=0 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND u.UpVotes=0 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.UpVotes=0 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, badges as b, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND v.UserId = u.Id AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE b.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes=0 AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes=0 AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b, votes as v WHERE b.UserId = u.Id AND v.UserId = u.Id AND u.UpVotes=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes=0 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes=0 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b, votes as v WHERE c.UserId = u.Id AND b.UserId = u.Id AND v.UserId = u.Id AND u.UpVotes=0 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b, votes as v WHERE b.UserId = u.Id AND ph.UserId = u.Id AND v.UserId = u.Id AND u.UpVotes=0 AND ph.PostHistoryTypeId=12;

-- count: 224
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, badges as b, votes as v, users as u WHERE u.Id =b.UserId AND b.UserId = ph.UserId AND ph.UserId = v.UserId AND v.UserId = c.UserId AND c.CreationDate>='2010-07-20 21:37:31'::timestamp AND ph.PostHistoryTypeId=12 AND u.UpVotes=0;

-- count: 18597973

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount<=50 AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date<='2014-08-25 19:05:46'::timestamp AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND v.BountyAmount<=50 AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND b.Date<='2014-08-25 19:05:46'::timestamp AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE v.UserId = u.Id AND b.UserId = u.Id AND b.Date<='2014-08-25 19:05:46'::timestamp AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND b.Date<='2014-08-25 19:05:46'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount<=50 AND c.Score=1 AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND c.Score=1 AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND b.Date<='2014-08-25 19:05:46'::timestamp AND c.Score=1 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND c.Score=1 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND c.Score=1 AND b.Date<='2014-08-25 19:05:46'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND b.Date<='2014-08-25 19:05:46'::timestamp AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND b.Date<='2014-08-25 19:05:46'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE v.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND v.BountyAmount<=50 AND b.Date<='2014-08-25 19:05:46'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND c.Score=1 AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND c.Score=1 AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND b.Date<='2014-08-25 19:05:46'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b WHERE c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND c.Score=1 AND v.BountyAmount<=50 AND b.Date<='2014-08-25 19:05:46'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND v.BountyAmount<=50 AND b.Date<='2014-08-25 19:05:46'::timestamp;

-- count: 18597973
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, votes as v, badges as b, users as u WHERE u.Id =c.UserId AND c.UserId = p.OwnerUserId AND p.OwnerUserId = v.UserId AND v.UserId = b.UserId AND c.Score=1 AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND v.BountyAmount<=50 AND b.Date<='2014-08-25 19:05:46'::timestamp AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp;

-- count: 9812

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0 AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE v.UserId = u.Id AND b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND c.Score=1 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND b.UserId = u.Id AND c.Score=1 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND c.Score=1 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE v.UserId = u.Id AND b.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND c.Score=1 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND c.Score=1 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND b.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND c.Score=1 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b WHERE c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND c.Score=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

-- count: 9812
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, votes as v, badges as b, users as u WHERE u.Id =c.UserId AND c.UserId = p.OwnerUserId AND p.OwnerUserId = v.UserId AND v.UserId = b.UserId AND c.Score=1 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0 AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51;

-- count: 86914174

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=2 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND b.Date>='2010-10-20 08:33:44'::timestamp AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Views>=0 AND u.Views<=75 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=2 AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date>='2010-10-20 08:33:44'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=75 AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-10-20 08:33:44'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Views>=0 AND u.Views<=75 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Views>=0 AND u.Views<=75 AND b.Date>='2010-10-20 08:33:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Id = p.OwnerUserId AND ph.PostHistoryTypeId=2 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND b.Date>='2010-10-20 08:33:44'::timestamp AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=75 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.Views<=75 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Views>=0 AND u.Views<=75 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND b.Date>='2010-10-20 08:33:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-10-20 08:33:44'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.Views>=0 AND u.Views<=75 AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views>=0 AND u.Views<=75 AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND b.Date>='2010-10-20 08:33:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.Views<=75 AND ph.PostHistoryTypeId=2 AND b.Date>='2010-10-20 08:33:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=75 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=75 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND b.Date>='2010-10-20 08:33:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.Views<=75 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND ph.PostHistoryTypeId=2 AND b.Date>='2010-10-20 08:33:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.Views<=75 AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND ph.PostHistoryTypeId=2 AND b.Date>='2010-10-20 08:33:44'::timestamp;

-- count: 86914174
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, badges as b, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.Id = b.UserId AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND ph.PostHistoryTypeId=2 AND b.Date>='2010-10-20 08:33:44'::timestamp AND u.Views>=0 AND u.Views<=75;

-- count: 228748307

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0 AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Id = p.OwnerUserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0 AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0 AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

-- count: 228748307
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, badges as b, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0 AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp;

-- count: 913441

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate<='2014-09-08 15:58:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.ViewCount>=0 AND c.CreationDate<='2014-09-08 15:58:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.ViewCount>=0 AND c.CreationDate<='2014-09-08 15:58:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Reputation>=1 AND c.CreationDate<='2014-09-08 15:58:08'::timestamp AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.CreationDate<='2014-09-08 15:58:08'::timestamp AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postLinks as pl, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Reputation>=1 AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.ViewCount>=0 AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Reputation>=1 AND c.CreationDate<='2014-09-08 15:58:08'::timestamp AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, posts as p, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND c.CreationDate<='2014-09-08 15:58:08'::timestamp AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.CreationDate<='2014-09-08 15:58:08'::timestamp AND p.ViewCount>=0 AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.ViewCount>=0 AND u.Reputation>=1;

-- count: 913441
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postLinks as pl, posts as p, users as u, badges as b WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND c.CreationDate<='2014-09-08 15:58:08'::timestamp AND p.ViewCount>=0 AND u.Reputation>=1;

-- count: 4801

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.CreationDate>='2011-02-08 18:11:37'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND u.CreationDate>='2011-02-08 18:11:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.CreationDate>='2011-02-08 18:11:37'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postLinks as pl, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.CreationDate>='2011-02-08 18:11:37'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0 AND u.CreationDate>='2011-02-08 18:11:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.CreationDate>='2011-02-08 18:11:37'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, posts as p, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0 AND u.CreationDate>='2011-02-08 18:11:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0 AND u.CreationDate>='2011-02-08 18:11:37'::timestamp;

-- count: 4801
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postLinks as pl, posts as p, users as u, badges as b WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0 AND u.CreationDate>='2011-02-08 18:11:37'::timestamp;

-- count: 14413

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, tags as t WHERE p.Id = t.ExcerptPostId AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes<=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, users as u WHERE u.Id = ph.UserId AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, tags as t, posts as p WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.DownVotes<=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND p.CommentCount>=0 AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND p.CommentCount>=0 AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u, postHistory as ph WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND p.CommentCount>=0 AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND p.CommentCount>=0 AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, postHistory as ph, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u, postHistory as ph WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND p.CommentCount>=0 AND u.DownVotes<=0;

-- count: 14413
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM tags as t, posts as p, users as u, postHistory as ph, badges as b WHERE p.Id = t.ExcerptPostId AND u.Id = ph.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND p.CommentCount>=0 AND u.DownVotes<=0 AND b.Date<='2014-08-22 02:21:55'::timestamp;

-- count: 15887370

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, tags as t WHERE p.Id = t.ExcerptPostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, users as u WHERE u.Id = v.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, tags as t, posts as p WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u, votes as v WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, votes as v, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.DownVotes>=0;

-- count: 15887370
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM tags as t, posts as p, users as u, votes as v, badges as b WHERE p.Id = t.ExcerptPostId AND u.Id = v.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND u.DownVotes>=0;

-- count: 5091

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, tags as t WHERE p.Id = t.ExcerptPostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.BountyAmount>=0 AND v.BountyAmount<=200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, users as u WHERE u.Id = v.UserId AND v.BountyAmount>=0 AND v.BountyAmount<=200 AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, tags as t, posts as p WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.BountyAmount>=0 AND v.BountyAmount<=200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.BountyAmount>=0 AND v.BountyAmount<=200 AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u, votes as v WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.BountyAmount>=0 AND v.BountyAmount<=200 AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, votes as v, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=200;

-- count: 5091
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM tags as t, posts as p, users as u, votes as v, badges as b WHERE p.Id = t.ExcerptPostId AND u.Id = v.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=200 AND b.Date<='2014-09-12 12:56:22'::timestamp;

-- count: 17849233970

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-09 10:24:35'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE u.Id = v.UserId AND u.Id = ph.UserId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-09 10:24:35'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-09 10:24:35'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND b.Date<='2014-09-09 10:24:35'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-09 10:24:35'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE u.Id = v.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND u.Id = ph.UserId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-09 10:24:35'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-09 10:24:35'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=5 AND ph.CreationDate<='2014-08-13 09:20:10'::timestamp AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-04 16:59:53'::timestamp AND u.CreationDate<='2014-07-22 15:15:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-09 10:24:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.LinkTypeId=1 AND p.AnswerCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=2 AND p.AnswerCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.AnswerCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE u.Id = v.UserId AND u.Id = ph.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=2 AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Id = ph.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=2 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE u.Id = v.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND ph.PostHistoryTypeId=2 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND u.Id = ph.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND u.Id = ph.UserId AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND u.Id = v.UserId AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND ph.PostHistoryTypeId=2 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND ph.PostHistoryTypeId=2 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND ph.PostHistoryTypeId=2 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND ph.PostHistoryTypeId=2 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

-- count: 88962973
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = v.UserId AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND ph.PostHistoryTypeId=2 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp;

-- count: 11947976

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

-- count: 11947976
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, votes as v, badges as b, users as u WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

-- count: 868310

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = b.UserId AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

-- count: 868310
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, votes as v, badges as b, users as u WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp;

-- count: 109961

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.UpVotes>=0 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId= u.Id AND u.UpVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.UpVotes>=0 AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.UpVotes>=0 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.UpVotes>=0 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.UpVotes>=0 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.UpVotes>=0 AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.UpVotes>=0 AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.UpVotes>=0 AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = b.UserId AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.UpVotes>=0 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.UpVotes>=0 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.UpVotes>=0 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = v.PostId AND u.UpVotes>=0 AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.UpVotes>=0 AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.UpVotes>=0 AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.UpVotes>=0 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

-- count: 109961
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, votes as v, badges as b, users as u WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp AND u.UpVotes>=0;

-- count: 8893

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = b.UserId AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

-- count: 8893
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, votes as v, badges as b, users as u WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp;

-- count: 692609

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, users as u, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, users as u, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = c.UserId AND p.Id = pl.PostId AND p.Id = c.PostId AND u.Id = v.UserId AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

-- count: 692609
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND p.Id = c.PostId AND u.Id = c.UserId AND u.Id = v.UserId AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND u.Reputation>=1 AND u.DownVotes>=0;

-- count: 33955

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2 AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, users as u, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, users as u, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = c.UserId AND p.Id = pl.PostId AND p.Id = c.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND ph.PostHistoryTypeId=5;

-- count: 33955
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND p.Id = c.PostId AND u.Id = c.UserId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=5 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp;

-- count: 82213

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, users as u, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, users as u, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = c.UserId AND p.Id = pl.PostId AND p.Id = c.PostId AND u.Id = v.UserId AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

-- count: 82213
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND p.Id = c.PostId AND u.Id = c.UserId AND u.Id = v.UserId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp;

-- count: 469

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=1 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.PostHistoryTypeId=1 AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=1 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=1 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=1 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, users as u, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, users as u, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=1 AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=1 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = c.UserId AND p.Id = pl.PostId AND p.Id = c.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, posts as p WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = pl.PostId AND u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND u.Id = v.UserId AND p.Id = ph.PostId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND ph.PostHistoryTypeId=1;

-- count: 469
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND p.Id = c.PostId AND u.Id = c.UserId AND u.Id = v.UserId AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND ph.PostHistoryTypeId=1 AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0;

-- count: 1112747282

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND b.UserId = u.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score<=32 AND p.ViewCount<=4146 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.LinkTypeId=1 AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.Score=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND b.UserId = u.Id AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.Score=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.Score=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0 AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND b.UserId = u.Id AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-07-30 03:49:24'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=5 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=5 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=5 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.VoteTypeId=5 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND b.UserId = u.Id AND p.CommentCount>=0 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.CommentCount>=0 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score<=67 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=34 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.PostHistoryTypeId=34 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=34 AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=34 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=34 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND p.Score<=67 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=34 AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.Score<=67 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND p.Score<=67 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND b.UserId = u.Id AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Score<=67 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.Score<=67 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND p.Score<=67 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND p.Score<=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND p.Score<=67 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date<='2014-08-20 12:16:56'::timestamp AND c.Score=0 AND p.Score<=67 AND ph.PostHistoryTypeId=34;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND c.CreationDate>='2010-07-22 01:19:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=15 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.CreationDate>='2010-07-22 01:19:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=15 AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=15 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=15 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND c.CreationDate>='2010-07-22 01:19:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.VoteTypeId=15 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=15 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=15 AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=15 AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=15 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND v.VoteTypeId=15 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=15 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND b.UserId = u.Id AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=15 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=15 AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = v.PostId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=15 AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND v.VoteTypeId=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = v.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

-- count: 38686327
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, badges as b, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5 AND u.DownVotes>=0;

-- count: 3812589

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation<=312 AND u.DownVotes<=0 AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation<=312 AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation<=312 AND u.DownVotes<=0 AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = v.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

-- count: 3812589
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, badges as b, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp AND u.Reputation<=312 AND u.DownVotes<=0;

-- count: 434967

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=2 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=2 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=2 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = v.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=2;

-- count: 434967
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, badges as b, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=2 AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6;

-- count: 5982882

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=5 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date>='2010-08-01 02:54:53'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND b.Date>='2010-08-01 02:54:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.VoteTypeId=5 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND b.Date>='2010-08-01 02:54:53'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND b.Date>='2010-08-01 02:54:53'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND b.Date>='2010-08-01 02:54:53'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND b.Date>='2010-08-01 02:54:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.VoteTypeId=5 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date>='2010-08-01 02:54:53'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND b.Date>='2010-08-01 02:54:53'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND b.Date>='2010-08-01 02:54:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND b.Date>='2010-08-01 02:54:53'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND b.Date>='2010-08-01 02:54:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5 AND b.Date>='2010-08-01 02:54:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.Date>='2010-08-01 02:54:53'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = v.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND b.Date>='2010-08-01 02:54:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5 AND b.Date>='2010-08-01 02:54:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5 AND b.Date>='2010-08-01 02:54:53'::timestamp;

-- count: 5982882
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, badges as b, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5 AND b.Date>='2010-08-01 02:54:53'::timestamp AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp;

-- count: 426751

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.BountyAmount<=50 AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.BountyAmount<=50 AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.BountyAmount<=50 AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.BountyAmount<=50 AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

-- count: 426751
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, badges as b, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

-- count: 2870375

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = v.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-11 18:35:08'::timestamp AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation<=240 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation<=240 AND b.Date<='2014-09-11 18:35:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND b.Date<='2014-09-11 18:35:08'::timestamp AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Reputation<=240 AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND b.Date<='2014-09-11 18:35:08'::timestamp AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.Reputation<=240 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND b.Date<='2014-09-11 18:35:08'::timestamp AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation<=240 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation<=240 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND b.Date<='2014-09-11 18:35:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date<='2014-09-11 18:35:08'::timestamp AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=240 AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = v.PostId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Id = p.OwnerUserId AND b.Date<='2014-09-11 18:35:08'::timestamp AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation<=240 AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Reputation<=240 AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND b.Date<='2014-09-11 18:35:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND b.Date<='2014-09-11 18:35:08'::timestamp AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation<=240 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND u.Reputation<=240 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND b.Date<='2014-09-11 18:35:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Reputation<=240 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-11 18:35:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.Date<='2014-09-11 18:35:08'::timestamp AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = v.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=240 AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation<=240 AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND b.Date<='2014-09-11 18:35:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = v.PostId AND u.Reputation<=240 AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-11 18:35:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation<=240 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-11 18:35:08'::timestamp;

-- count: 2870375
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, badges as b, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-11 18:35:08'::timestamp AND u.Reputation<=240;

-- count: 1459345

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2010-07-26 09:46:48'::timestamp AND p.CreationDate<='2014-09-13 10:09:50'::timestamp AND c.CreationDate>='2010-07-27 17:46:38'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Reputation>=1 AND u.CreationDate>='2010-08-03 19:42:40'::timestamp AND u.CreationDate<='2014-09-12 02:20:03'::timestamp AND c.CreationDate>='2010-07-27 17:46:38'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND u.CreationDate>='2010-08-03 19:42:40'::timestamp AND u.CreationDate<='2014-09-12 02:20:03'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2010-07-26 09:46:48'::timestamp AND p.CreationDate<='2014-09-13 10:09:50'::timestamp;

-- count: 1459345
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND c.UserId = u.Id AND c.CreationDate>='2010-07-27 17:46:38'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2010-07-26 09:46:48'::timestamp AND p.CreationDate<='2014-09-13 10:09:50'::timestamp AND u.Reputation>=1 AND u.CreationDate>='2010-08-03 19:42:40'::timestamp AND u.CreationDate<='2014-09-12 02:20:03'::timestamp;

-- count: 657592

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND p.AnswerCount<=5 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=27 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Reputation>=1 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND p.AnswerCount<=5 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=27;

-- count: 657592
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND c.UserId = u.Id AND c.Score=0 AND p.AnswerCount<=5 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=27 AND u.Reputation>=1;

-- count: 1771584

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND c.CreationDate>='2010-08-09 07:24:50'::timestamp AND c.CreationDate<='2014-09-10 03:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Reputation>=1 AND u.Views<=80 AND u.UpVotes>=0 AND u.CreationDate>='2010-08-02 20:31:12'::timestamp AND c.CreationDate>='2010-08-09 07:24:50'::timestamp AND c.CreationDate<='2014-09-10 03:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation>=1 AND u.Views<=80 AND u.UpVotes>=0 AND u.CreationDate>='2010-08-02 20:31:12'::timestamp;

-- count: 1771584
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND c.CreationDate>='2010-08-09 07:24:50'::timestamp AND c.CreationDate<='2014-09-10 03:46:02'::timestamp AND u.Reputation>=1 AND u.Views<=80 AND u.UpVotes>=0 AND u.CreationDate>='2010-08-02 20:31:12'::timestamp;

-- count: 2323452

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=7931 AND u.Views<=109 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 13:12:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=7931 AND u.Views<=109 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 13:12:56'::timestamp;

-- count: 2323452
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=7931 AND u.Views<=109 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 13:12:56'::timestamp;

-- count: 10993951

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-07-27 15:46:34'::timestamp AND c.CreationDate<='2014-09-12 08:15:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.CreationDate<='2014-09-03 01:06:41'::timestamp AND c.CreationDate>='2010-07-27 15:46:34'::timestamp AND c.CreationDate<='2014-09-12 08:15:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.CreationDate<='2014-09-03 01:06:41'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

-- count: 10993951
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.CreationDate>='2010-07-27 15:46:34'::timestamp AND c.CreationDate<='2014-09-12 08:15:14'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND u.CreationDate<='2014-09-03 01:06:41'::timestamp;

-- count: 10862842

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.CreationDate>='2010-07-19 20:11:48'::timestamp AND u.CreationDate<='2014-07-09 20:37:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.CreationDate>='2010-07-19 20:11:48'::timestamp AND u.CreationDate<='2014-07-09 20:37:10'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

-- count: 10862842
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND u.CreationDate>='2010-07-19 20:11:48'::timestamp AND u.CreationDate<='2014-07-09 20:37:10'::timestamp;

-- count: 209182

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Views>=0 AND u.Views<=74 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE v.PostId = p.Id;

-- count: 209182
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, users as u, posts as p WHERE c.PostId = p.Id AND u.Id = c.UserId AND v.PostId = p.Id AND c.Score=0 AND u.Views>=0 AND u.Views<=74;

-- count: 758411

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, votes as v WHERE c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND c.PostId = p.Id AND c.Score=0 AND u.Views>=0 AND u.Views<=74;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, posts as p WHERE u.Id = c.UserId AND c.PostId = p.Id AND v.PostId = p.Id AND u.Views>=0 AND u.Views<=74 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.CreationDate>='2010-08-12 20:27:30'::timestamp AND c.CreationDate<='2014-09-12 12:49:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=2 AND c.CreationDate>='2010-08-12 20:27:30'::timestamp AND c.CreationDate<='2014-09-12 12:49:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=2;

-- count: 758411
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, badges as b, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.CreationDate>='2010-08-12 20:27:30'::timestamp AND c.CreationDate<='2014-09-12 12:49:19'::timestamp AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=2;

-- count: 10223864

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-07-19 20:34:06'::timestamp AND b.Date<='2014-09-12 15:11:36'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-24 06:46:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.UpVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-07-24 06:46:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.UpVotes>=0 AND b.Date>='2010-07-19 20:34:06'::timestamp AND b.Date<='2014-09-12 15:11:36'::timestamp;

-- count: 10223864
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, badges as b, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.Score=0 AND c.CreationDate>='2010-07-24 06:46:49'::timestamp AND b.Date>='2010-07-19 20:34:06'::timestamp AND b.Date<='2014-09-12 15:11:36'::timestamp AND u.UpVotes>=0;

-- count: 1356723

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=23;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.DownVotes=0 AND u.UpVotes>=0 AND u.UpVotes<=244;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.DownVotes=0 AND u.UpVotes>=0 AND u.UpVotes<=244 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=23;

-- count: 1356723
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=23 AND u.DownVotes=0 AND u.UpVotes>=0 AND u.UpVotes<=244;

-- count: 582617

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.FavoriteCount<=5 AND ph.CreationDate>='2011-05-20 18:43:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Views>=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-27 21:46:49'::timestamp AND u.CreationDate<='2014-08-18 13:00:22'::timestamp AND ph.CreationDate>='2011-05-20 18:43:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Views>=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-27 21:46:49'::timestamp AND u.CreationDate<='2014-08-18 13:00:22'::timestamp AND p.FavoriteCount<=5;

-- count: 582617
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2011-05-20 18:43:03'::timestamp AND p.FavoriteCount<=5 AND u.Views>=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-27 21:46:49'::timestamp AND u.CreationDate<='2014-08-18 13:00:22'::timestamp;

-- count: 4197329

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.Score>=0 AND ph.CreationDate>='2010-08-21 05:30:40'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation>=1 AND u.UpVotes<=198 AND u.CreationDate>='2010-07-19 20:49:05'::timestamp AND ph.CreationDate>='2010-08-21 05:30:40'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Reputation>=1 AND u.UpVotes<=198 AND u.CreationDate>='2010-07-19 20:49:05'::timestamp AND p.Score>=0;

-- count: 4197329
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-08-21 05:30:40'::timestamp AND p.Score>=0 AND u.Reputation>=1 AND u.UpVotes<=198 AND u.CreationDate>='2010-07-19 20:49:05'::timestamp;

-- count: 155561

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE ph.PostId = p.Id AND p.CreationDate>='2010-08-17 19:08:05'::timestamp AND p.CreationDate<='2014-08-31 06:58:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.UpVotes>=0 AND u.UpVotes<=9 AND p.CreationDate>='2010-08-17 19:08:05'::timestamp AND p.CreationDate<='2014-08-31 06:58:12'::timestamp;

-- count: 155561
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE ph.PostId = p.Id AND p.OwnerUserId = u.Id AND p.CreationDate>='2010-08-17 19:08:05'::timestamp AND p.CreationDate<='2014-08-31 06:58:12'::timestamp AND u.UpVotes>=0 AND u.UpVotes<=9;

-- count: 2162683

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND p.PostTypeId=2 AND p.CreationDate<='2014-08-26 22:40:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.Views>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Views>=0 AND p.PostTypeId=2 AND p.CreationDate<='2014-08-26 22:40:26'::timestamp;

-- count: 2162683
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE v.UserId = u.Id AND p.OwnerUserId = u.Id AND p.PostTypeId=2 AND p.CreationDate<='2014-08-26 22:40:26'::timestamp AND u.Views>=0;

-- count: 1100297

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.CreationDate>='2010-12-15 06:00:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.CreationDate>='2010-12-15 06:00:24'::timestamp AND p.CommentCount>=0;

-- count: 1100297
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE v.UserId = u.Id AND p.OwnerUserId = u.Id AND p.CommentCount>=0 AND u.CreationDate>='2010-12-15 06:00:24'::timestamp;

-- count: 4254157

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE v.PostId = p.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

-- count: 4254157
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, votes as v, posts as p WHERE ph.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

-- count: 2016238

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph WHERE c.PostId = p.Id AND ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, votes as v WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, votes as v WHERE v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate<='2014-09-05 06:39:25'::timestamp AND c.Score=0 AND c.CreationDate>='2010-08-26 06:55:11'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.VoteTypeId=2 AND c.Score=0 AND c.CreationDate>='2010-08-26 06:55:11'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id AND c.Score=0 AND c.CreationDate>='2010-08-26 06:55:11'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE v.PostId = p.Id AND ph.PostId = p.Id AND v.VoteTypeId=2 AND ph.CreationDate<='2014-09-05 06:39:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE ph.PostId = p.Id AND ph.CreationDate<='2014-09-05 06:39:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE v.PostId = p.Id AND v.VoteTypeId=2;

-- count: 2016238
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, votes as v, posts as p WHERE ph.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND c.CreationDate>='2010-08-26 06:55:11'::timestamp AND ph.CreationDate<='2014-09-05 06:39:25'::timestamp AND v.VoteTypeId=2;

-- count: 56359398

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph WHERE c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0 AND c.CreationDate>='2010-08-26 06:55:11'::timestamp AND ph.CreationDate<='2014-09-05 06:39:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, votes as v WHERE c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND c.CreationDate>='2010-08-26 06:55:11'::timestamp AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, votes as v WHERE v.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate<='2014-09-05 06:39:25'::timestamp AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.VoteTypeId=2 AND c.Score=0 AND c.CreationDate>='2010-08-26 06:55:11'::timestamp AND ph.CreationDate<='2014-09-05 06:39:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.Score>=0 AND p.Score<=28 AND p.ViewCount>=0 AND p.ViewCount<=6517 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.FavoriteCount>=0 AND p.FavoriteCount<=8 AND p.CreationDate>='2010-07-27 11:29:20'::timestamp AND p.CreationDate<='2014-09-13 02:50:15'::timestamp AND c.CreationDate>='2010-07-27 12:03:40'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.CreationDate>='2010-07-27 12:03:40'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Views>=0 AND u.CreationDate>='2010-07-27 09:38:05'::timestamp AND c.CreationDate>='2010-07-27 12:03:40'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.Score>=0 AND p.Score<=28 AND p.ViewCount>=0 AND p.ViewCount<=6517 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.FavoriteCount>=0 AND p.FavoriteCount<=8 AND p.CreationDate>='2010-07-27 11:29:20'::timestamp AND p.CreationDate<='2014-09-13 02:50:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views>=0 AND u.CreationDate>='2010-07-27 09:38:05'::timestamp AND p.Score>=0 AND p.Score<=28 AND p.ViewCount>=0 AND p.ViewCount<=6517 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.FavoriteCount>=0 AND p.FavoriteCount<=8 AND p.CreationDate>='2010-07-27 11:29:20'::timestamp AND p.CreationDate<='2014-09-13 02:50:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Views>=0 AND u.CreationDate>='2010-07-27 09:38:05'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND c.CreationDate>='2010-07-27 12:03:40'::timestamp AND p.Score>=0 AND p.Score<=28 AND p.ViewCount>=0 AND p.ViewCount<=6517 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.FavoriteCount>=0 AND p.FavoriteCount<=8 AND p.CreationDate>='2010-07-27 11:29:20'::timestamp AND p.CreationDate<='2014-09-13 02:50:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Views>=0 AND u.CreationDate>='2010-07-27 09:38:05'::timestamp AND c.CreationDate>='2010-07-27 12:03:40'::timestamp AND p.Score>=0 AND p.Score<=28 AND p.ViewCount>=0 AND p.ViewCount<=6517 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.FavoriteCount>=0 AND p.FavoriteCount<=8 AND p.CreationDate>='2010-07-27 11:29:20'::timestamp AND p.CreationDate<='2014-09-13 02:50:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate>='2010-07-27 09:38:05'::timestamp AND c.CreationDate>='2010-07-27 12:03:40'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate>='2010-07-27 09:38:05'::timestamp AND p.Score>=0 AND p.Score<=28 AND p.ViewCount>=0 AND p.ViewCount<=6517 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.FavoriteCount>=0 AND p.FavoriteCount<=8 AND p.CreationDate>='2010-07-27 11:29:20'::timestamp AND p.CreationDate<='2014-09-13 02:50:15'::timestamp;

-- count: 56359398
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = c.UserId AND u.Id = v.UserId AND c.CreationDate>='2010-07-27 12:03:40'::timestamp AND p.Score>=0 AND p.Score<=28 AND p.ViewCount>=0 AND p.ViewCount<=6517 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.FavoriteCount>=0 AND p.FavoriteCount<=8 AND p.CreationDate>='2010-07-27 11:29:20'::timestamp AND p.CreationDate<='2014-09-13 02:50:15'::timestamp AND u.Views>=0 AND u.CreationDate>='2010-07-27 09:38:05'::timestamp;

-- count: 40855663

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.Score<=52 AND p.AnswerCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.UpVotes>=0 AND u.CreationDate>='2010-10-05 05:52:35'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND p.Score<=52 AND p.AnswerCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.UpVotes>=0 AND u.CreationDate>='2010-10-05 05:52:35'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp AND p.Score<=52 AND p.AnswerCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.UpVotes>=0 AND u.CreationDate>='2010-10-05 05:52:35'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND p.Score<=52 AND p.AnswerCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.UpVotes>=0 AND u.CreationDate>='2010-10-05 05:52:35'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp AND p.Score<=52 AND p.AnswerCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.UpVotes>=0 AND u.CreationDate>='2010-10-05 05:52:35'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.UpVotes>=0 AND u.CreationDate>='2010-10-05 05:52:35'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp AND p.Score<=52 AND p.AnswerCount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

-- count: 40855663
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = c.UserId AND u.Id = v.UserId AND p.Score<=52 AND p.AnswerCount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND u.UpVotes>=0 AND u.CreationDate>='2010-10-05 05:52:35'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp;

-- count: 1490297

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.ViewCount>=0 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Reputation<=306 AND u.UpVotes>=0 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation<=306 AND u.UpVotes>=0 AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Reputation<=306 AND u.UpVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND c.Score=0 AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Reputation<=306 AND u.UpVotes>=0 AND c.Score=0 AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Reputation<=306 AND u.UpVotes>=0 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Reputation<=306 AND u.UpVotes>=0 AND p.ViewCount>=0;

-- count: 1490297
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = c.UserId AND u.Id = v.UserId AND c.Score=0 AND p.ViewCount>=0 AND u.Reputation<=306 AND u.UpVotes>=0;

-- count: 303210

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=0 AND p.Score<=16 AND p.ViewCount>=0 AND p.CreationDate<='2014-09-09 12:00:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.Score>=0 AND p.Score<=16 AND p.ViewCount>=0 AND p.CreationDate<='2014-09-09 12:00:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND u.CreationDate>='2010-07-19 19:08:49'::timestamp AND u.CreationDate<='2014-08-28 12:15:56'::timestamp AND p.Score>=0 AND p.Score<=16 AND p.ViewCount>=0 AND p.CreationDate<='2014-09-09 12:00:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Score>=0 AND p.Score<=16 AND p.ViewCount>=0 AND p.CreationDate<='2014-09-09 12:00:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.CreationDate>='2010-07-19 19:08:49'::timestamp AND u.CreationDate<='2014-08-28 12:15:56'::timestamp AND p.Score>=0 AND p.Score<=16 AND p.ViewCount>=0 AND p.CreationDate<='2014-09-09 12:00:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2010-07-19 19:08:49'::timestamp AND u.CreationDate<='2014-08-28 12:15:56'::timestamp AND p.Score>=0 AND p.Score<=16 AND p.ViewCount>=0 AND p.CreationDate<='2014-09-09 12:00:50'::timestamp;

-- count: 303210
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = c.PostId AND p.Score>=0 AND p.Score<=16 AND p.ViewCount>=0 AND p.CreationDate<='2014-09-09 12:00:50'::timestamp AND u.Reputation>=1 AND u.CreationDate>='2010-07-19 19:08:49'::timestamp AND u.CreationDate<='2014-08-28 12:15:56'::timestamp;

-- count: 408599

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=0 AND p.Score<=19 AND p.CommentCount<=10 AND p.CreationDate<='2014-08-28 13:31:33'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-10 02:47:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-10 02:47:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.Score>=0 AND p.Score<=19 AND p.CommentCount<=10 AND p.CreationDate<='2014-08-28 13:31:33'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes>=0 AND p.Score>=0 AND p.Score<=19 AND p.CommentCount<=10 AND p.CreationDate<='2014-08-28 13:31:33'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-10 02:47:53'::timestamp AND p.Score>=0 AND p.Score<=19 AND p.CommentCount<=10 AND p.CreationDate<='2014-08-28 13:31:33'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate<='2014-09-10 02:47:53'::timestamp AND p.Score>=0 AND p.Score<=19 AND p.CommentCount<=10 AND p.CreationDate<='2014-08-28 13:31:33'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=0 AND p.Score<=19 AND p.CommentCount<=10 AND p.CreationDate<='2014-08-28 13:31:33'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

-- count: 408599
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate<='2014-09-10 02:47:53'::timestamp AND p.Score>=0 AND p.Score<=19 AND p.CommentCount<=10 AND p.CreationDate<='2014-08-28 13:31:33'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND u.DownVotes>=0;

-- count: 2809424

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE p.Id = v.PostId AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.CreationDate<='2014-09-12 00:03:32'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-11 07:27:36'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.CreationDate<='2014-09-12 00:03:32'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.CreationDate<='2014-09-12 00:03:32'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND b.Date<='2014-09-11 07:27:36'::timestamp;

-- count: 2809424
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, badges as b, users as u WHERE u.Id = b.UserId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.CreationDate<='2014-09-12 00:03:32'::timestamp AND b.Date<='2014-09-11 07:27:36'::timestamp;

-- count: 3778084

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.CreationDate<='2014-09-12 00:03:32'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.CreationDate<='2014-09-12 00:03:32'::timestamp AND b.Date<='2014-09-11 07:27:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND b.Date<='2014-09-11 07:27:36'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.CreationDate<='2014-09-12 00:03:32'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=1 AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=1 AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=1 AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=15;

-- count: 3778084
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, badges as b, users as u WHERE u.Id = b.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=15 AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=1;

-- count: 11075893

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-07-28 09:11:34'::timestamp AND ph.CreationDate<='2014-09-06 06:51:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=72;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-07-28 09:11:34'::timestamp AND ph.CreationDate<='2014-09-06 06:51:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=72 AND ph.CreationDate>='2010-07-28 09:11:34'::timestamp AND ph.CreationDate<='2014-09-06 06:51:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=72;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=72 AND ph.CreationDate>='2010-07-28 09:11:34'::timestamp AND ph.CreationDate<='2014-09-06 06:51:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=72;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=72 AND ph.CreationDate>='2010-07-28 09:11:34'::timestamp AND ph.CreationDate<='2014-09-06 06:51:53'::timestamp;

-- count: 11075893
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, votes as v, users as u WHERE v.UserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-07-28 09:11:34'::timestamp AND ph.CreationDate<='2014-09-06 06:51:53'::timestamp AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=72;

-- count: 183537163

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND c.Score=0 AND c.CreationDate>='2010-07-19 19:56:21'::timestamp AND c.CreationDate<='2014-09-11 13:36:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND c.Score=0 AND c.CreationDate>='2010-07-19 19:56:21'::timestamp AND c.CreationDate<='2014-09-11 13:36:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Views<=433 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 21:37:39'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-19 19:56:21'::timestamp AND c.CreationDate<='2014-09-11 13:36:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Views<=433 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 21:37:39'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.Views<=433 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 21:37:39'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Views<=433 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 21:37:39'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-19 19:56:21'::timestamp AND c.CreationDate<='2014-09-11 13:36:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.Views<=433 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 21:37:39'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-19 19:56:21'::timestamp AND c.CreationDate<='2014-09-11 13:36:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.Views<=433 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 21:37:39'::timestamp;

-- count: 183537163
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, votes as v, users as u WHERE v.UserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND c.Score=0 AND c.CreationDate>='2010-07-19 19:56:21'::timestamp AND c.CreationDate<='2014-09-11 13:36:12'::timestamp AND u.Views<=433 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 21:37:39'::timestamp;

-- count: 569476

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=2 AND c.CreationDate<='2014-08-28 07:25:55'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND c.CreationDate<='2014-08-28 07:25:55'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=15 AND u.CreationDate>='2010-09-03 11:45:16'::timestamp AND u.CreationDate<='2014-08-18 17:19:53'::timestamp AND c.CreationDate<='2014-08-28 07:25:55'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=15 AND u.CreationDate>='2010-09-03 11:45:16'::timestamp AND u.CreationDate<='2014-08-18 17:19:53'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=15 AND u.CreationDate>='2010-09-03 11:45:16'::timestamp AND u.CreationDate<='2014-08-18 17:19:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=15 AND u.CreationDate>='2010-09-03 11:45:16'::timestamp AND u.CreationDate<='2014-08-18 17:19:53'::timestamp AND c.CreationDate<='2014-08-28 07:25:55'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=15 AND u.CreationDate>='2010-09-03 11:45:16'::timestamp AND u.CreationDate<='2014-08-18 17:19:53'::timestamp AND c.CreationDate<='2014-08-28 07:25:55'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=15 AND u.CreationDate>='2010-09-03 11:45:16'::timestamp AND u.CreationDate<='2014-08-18 17:19:53'::timestamp AND ph.PostHistoryTypeId=2;

-- count: 569476
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, votes as v, users as u WHERE v.UserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND c.CreationDate<='2014-08-28 07:25:55'::timestamp AND ph.PostHistoryTypeId=2 AND u.Reputation>=1 AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=15 AND u.CreationDate>='2010-09-03 11:45:16'::timestamp AND u.CreationDate<='2014-08-18 17:19:53'::timestamp;

-- count: 537352263

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND v.VoteTypeId=5 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-13 00:00:00'::timestamp AND c.Score=1 AND c.CreationDate>='2010-08-27 14:12:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND b.Date<='2014-08-19 10:32:13'::timestamp AND c.Score=1 AND c.CreationDate>='2010-08-27 14:12:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Reputation>=1 AND c.Score=1 AND c.CreationDate>='2010-08-27 14:12:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-08-19 10:32:13'::timestamp AND v.VoteTypeId=5 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-13 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Reputation>=1 AND v.VoteTypeId=5 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-13 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND b.Date<='2014-08-19 10:32:13'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-08-19 10:32:13'::timestamp AND c.Score=1 AND c.CreationDate>='2010-08-27 14:12:07'::timestamp AND v.VoteTypeId=5 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-13 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND c.Score=1 AND c.CreationDate>='2010-08-27 14:12:07'::timestamp AND v.VoteTypeId=5 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-13 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Reputation>=1 AND c.Score=1 AND c.CreationDate>='2010-08-27 14:12:07'::timestamp AND b.Date<='2014-08-19 10:32:13'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND v.VoteTypeId=5 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-13 00:00:00'::timestamp AND b.Date<='2014-08-19 10:32:13'::timestamp;

-- count: 537352263
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, badges as b, users as u WHERE u.Id = b.UserId AND u.Id = c.UserId AND u.Id = v.UserId AND c.Score=1 AND c.CreationDate>='2010-08-27 14:12:07'::timestamp AND v.VoteTypeId=5 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-13 00:00:00'::timestamp AND b.Date<='2014-08-19 10:32:13'::timestamp AND u.Reputation>=1;

-- count: 593169291

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = v.UserId AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp;

-- count: 593169291
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v, badges as b, users as u WHERE u.Id = b.UserId AND u.Id = c.UserId AND u.Id = v.UserId AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp AND u.CreationDate>='2010-07-20 01:27:29'::timestamp;

-- count: 978405

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE pl.PostId = p.Id AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE v.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl WHERE pl.PostId = p.Id AND c.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph WHERE c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, votes as v WHERE c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, votes as v WHERE pl.PostId = p.Id AND v.PostId = p.Id AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, votes as v WHERE v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

-- count: 978405
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

-- count: 1104151

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, postHistory as ph WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, votes as v WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph, votes as v WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE pl.PostId = p.Id AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE v.PostId = p.Id AND ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE v.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl WHERE pl.PostId = p.Id AND c.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph WHERE c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, votes as v WHERE c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, votes as v WHERE pl.PostId = p.Id AND v.PostId = p.Id AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, votes as v WHERE v.PostId = p.Id AND ph.PostId = p.Id;

-- count: 1104151
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

-- count: 1957551

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, postHistory as ph WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, votes as v WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph, votes as v WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE pl.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE ph.PostId = p.Id AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE v.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl WHERE pl.PostId = p.Id AND c.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph WHERE c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, votes as v WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, votes as v WHERE pl.PostId = p.Id AND v.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, votes as v WHERE v.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

-- count: 1957551
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

-- count: 1839326

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, postHistory as ph WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, votes as v WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph, votes as v WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE pl.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, votes as v WHERE v.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl WHERE pl.PostId = p.Id AND c.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph WHERE c.PostId = p.Id AND ph.PostId = p.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, votes as v WHERE c.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, votes as v WHERE pl.PostId = p.Id AND v.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, votes as v WHERE v.PostId = p.Id AND ph.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

-- count: 1839326
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

-- count: 18382871

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, postHistory as ph WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, votes as v WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph, votes as v WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = p.Id AND v.PostId = p.Id AND ph.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND c.CreationDate<='2014-09-10 00:33:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.CreationDate<='2014-09-10 00:33:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.DownVotes<=0 AND u.UpVotes<=47 AND c.CreationDate<='2014-09-10 00:33:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes<=47;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.DownVotes<=0 AND u.UpVotes<=47;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes<=47 AND c.CreationDate<='2014-09-10 00:33:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.DownVotes<=0 AND u.UpVotes<=47 AND c.CreationDate<='2014-09-10 00:33:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes<=47;

-- count: 18382871
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, badges as b, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = c.UserId AND c.CreationDate<='2014-09-10 00:33:30'::timestamp AND u.DownVotes<=0 AND u.UpVotes<=47;

-- count: 19424781

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-01 13:56:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND b.Date<='2014-09-02 23:33:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=62 AND u.CreationDate>='2010-07-27 17:10:30'::timestamp AND u.CreationDate<='2014-07-31 18:48:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-02 23:33:16'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-01 13:56:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=62 AND u.CreationDate>='2010-07-27 17:10:30'::timestamp AND u.CreationDate<='2014-07-31 18:48:36'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-01 13:56:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=62 AND u.CreationDate>='2010-07-27 17:10:30'::timestamp AND u.CreationDate<='2014-07-31 18:48:36'::timestamp AND b.Date<='2014-09-02 23:33:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=62 AND u.CreationDate>='2010-07-27 17:10:30'::timestamp AND u.CreationDate<='2014-07-31 18:48:36'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-01 13:56:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=62 AND u.CreationDate>='2010-07-27 17:10:30'::timestamp AND u.CreationDate<='2014-07-31 18:48:36'::timestamp AND b.Date<='2014-09-02 23:33:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=62 AND u.CreationDate>='2010-07-27 17:10:30'::timestamp AND u.CreationDate<='2014-07-31 18:48:36'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-01 13:56:22'::timestamp AND b.Date<='2014-09-02 23:33:16'::timestamp;

-- count: 19424781
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, badges as b, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = c.UserId AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-01 13:56:22'::timestamp AND b.Date<='2014-09-02 23:33:16'::timestamp AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=62 AND u.CreationDate>='2010-07-27 17:10:30'::timestamp AND u.CreationDate<='2014-07-31 18:48:36'::timestamp;

-- count: 43927632

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND c.CreationDate<='2014-08-28 00:18:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND b.Date>='2010-09-15 02:50:48'::timestamp AND c.CreationDate<='2014-08-28 00:18:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Reputation>=1 AND u.Reputation<=1443 AND u.DownVotes>=0 AND u.DownVotes<=3 AND c.CreationDate<='2014-08-28 00:18:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-09-15 02:50:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=1443 AND u.DownVotes>=0 AND u.DownVotes<=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND u.Reputation<=1443 AND u.DownVotes>=0 AND u.DownVotes<=3 AND b.Date>='2010-09-15 02:50:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=1443 AND u.DownVotes>=0 AND u.DownVotes<=3 AND c.CreationDate<='2014-08-28 00:18:24'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.Reputation<=1443 AND u.DownVotes>=0 AND u.DownVotes<=3 AND c.CreationDate<='2014-08-28 00:18:24'::timestamp AND b.Date>='2010-09-15 02:50:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=1443 AND u.DownVotes>=0 AND u.DownVotes<=3 AND b.Date>='2010-09-15 02:50:48'::timestamp;

-- count: 43927632
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, badges as b, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = c.UserId AND c.CreationDate<='2014-08-28 00:18:24'::timestamp AND b.Date>='2010-09-15 02:50:48'::timestamp AND u.Reputation>=1 AND u.Reputation<=1443 AND u.DownVotes>=0 AND u.DownVotes<=3;

-- count: 986987

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND ph.CreationDate>='2010-08-19 12:45:55'::timestamp AND ph.CreationDate<='2014-09-03 21:46:37'::timestamp AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Reputation>=1 AND u.Reputation<=1183 AND u.Views>=0 AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND ph.CreationDate>='2010-08-19 12:45:55'::timestamp AND ph.CreationDate<='2014-09-03 21:46:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=1183 AND u.Views>=0 AND ph.CreationDate>='2010-08-19 12:45:55'::timestamp AND ph.CreationDate<='2014-09-03 21:46:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND u.Reputation<=1183 AND u.Views>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=1183 AND u.Views>=0 AND c.Score=2 AND ph.CreationDate>='2010-08-19 12:45:55'::timestamp AND ph.CreationDate<='2014-09-03 21:46:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.Reputation<=1183 AND u.Views>=0 AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=1183 AND u.Views>=0 AND ph.CreationDate>='2010-08-19 12:45:55'::timestamp AND ph.CreationDate<='2014-09-03 21:46:37'::timestamp;

-- count: 986987
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, badges as b, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = c.UserId AND c.Score=2 AND ph.CreationDate>='2010-08-19 12:45:55'::timestamp AND ph.CreationDate<='2014-09-03 21:46:37'::timestamp AND u.Reputation>=1 AND u.Reputation<=1183 AND u.Views>=0;

-- count: 354388

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE p.Id = ph.PostId AND p.ViewCount>=0 AND p.CommentCount>=0 AND ph.CreationDate>='2010-07-21 00:44:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND ph.CreationDate>='2010-07-21 00:44:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=2 AND p.ViewCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=34 AND u.UpVotes>=0 AND p.ViewCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND ph.CreationDate>='2010-07-21 00:44:08'::timestamp AND p.ViewCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.Views>=0 AND u.Views<=34 AND u.UpVotes>=0 AND ph.CreationDate>='2010-07-21 00:44:08'::timestamp AND p.ViewCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Views>=0 AND u.Views<=34 AND u.UpVotes>=0 AND p.ViewCount>=0 AND p.CommentCount>=0 AND v.VoteTypeId=2;

-- count: 354388
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND p.Id = v.PostId AND ph.CreationDate>='2010-07-21 00:44:08'::timestamp AND p.ViewCount>=0 AND p.CommentCount>=0 AND v.VoteTypeId=2 AND u.Views>=0 AND u.Views<=34 AND u.UpVotes>=0;

-- count: 554302

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph WHERE p.Id = ph.PostId AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND ph.CreationDate<='2014-07-28 13:25:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-03 00:00:00'::timestamp AND ph.CreationDate<='2014-07-28 13:25:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-03 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.AnswerCount<=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes=0 AND u.CreationDate<='2014-08-08 07:03:29'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.AnswerCount<=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-03 00:00:00'::timestamp AND ph.CreationDate<='2014-07-28 13:25:35'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.AnswerCount<=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.DownVotes=0 AND u.CreationDate<='2014-08-08 07:03:29'::timestamp AND ph.CreationDate<='2014-07-28 13:25:35'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.AnswerCount<=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes=0 AND u.CreationDate<='2014-08-08 07:03:29'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-03 00:00:00'::timestamp;

-- count: 554302
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND p.Id = v.PostId AND ph.CreationDate<='2014-07-28 13:25:35'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-03 00:00:00'::timestamp AND u.DownVotes=0 AND u.CreationDate<='2014-08-08 07:03:29'::timestamp;

-- count: 1936953

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.ViewCount>=0 AND p.ViewCount<=2024 AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=750 AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-07-20 10:34:10'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Reputation>=1 AND u.Reputation<=750 AND p.ViewCount>=0 AND p.ViewCount<=2024;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-07-20 10:34:10'::timestamp AND p.ViewCount>=0 AND p.ViewCount<=2024;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE b.UserId = u.Id AND b.Date>='2010-07-20 10:34:10'::timestamp AND u.Reputation>=1 AND u.Reputation<=750;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=750 AND ph.PostHistoryTypeId=5 AND p.ViewCount>=0 AND p.ViewCount<=2024;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-07-20 10:34:10'::timestamp AND ph.PostHistoryTypeId=5 AND p.ViewCount>=0 AND p.ViewCount<=2024;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-07-20 10:34:10'::timestamp AND ph.PostHistoryTypeId=5 AND u.Reputation>=1 AND u.Reputation<=750;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-07-20 10:34:10'::timestamp AND p.ViewCount>=0 AND p.ViewCount<=2024 AND u.Reputation>=1 AND u.Reputation<=750;

-- count: 1936953
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u, badges as b WHERE b.UserId = u.Id AND p.OwnerUserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=5 AND p.ViewCount>=0 AND p.ViewCount<=2024 AND u.Reputation>=1 AND u.Reputation<=750 AND b.Date>='2010-07-20 10:34:10'::timestamp;

-- count: 11637523617

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.Score>=0 AND ph.CreationDate>='2010-07-19 19:52:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.CreationDate>='2010-07-27 02:56:06'::timestamp AND u.CreationDate<='2014-09-10 10:44:00'::timestamp AND ph.CreationDate>='2010-07-19 19:52:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-07-19 19:52:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.CreationDate>='2010-07-27 02:56:06'::timestamp AND u.CreationDate<='2014-09-10 10:44:00'::timestamp AND p.Score>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.Score>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE b.UserId = u.Id AND u.CreationDate>='2010-07-27 02:56:06'::timestamp AND u.CreationDate<='2014-09-10 10:44:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.CreationDate>='2010-07-27 02:56:06'::timestamp AND u.CreationDate<='2014-09-10 10:44:00'::timestamp AND ph.CreationDate>='2010-07-19 19:52:31'::timestamp AND p.Score>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-07-19 19:52:31'::timestamp AND u.CreationDate>='2010-07-27 02:56:06'::timestamp AND u.CreationDate<='2014-09-10 10:44:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.Score>=0 AND u.CreationDate>='2010-07-27 02:56:06'::timestamp AND u.CreationDate<='2014-09-10 10:44:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=89 AND p.CreationDate<='2014-09-02 10:21:04'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2011-01-08 03:03:48'::timestamp AND ph.CreationDate<='2014-08-25 14:04:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Reputation<=705 AND u.CreationDate>='2010-07-28 23:56:00'::timestamp AND u.CreationDate<='2014-09-02 10:04:41'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2011-01-08 03:03:48'::timestamp AND ph.CreationDate<='2014-08-25 14:04:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-07-20 20:47:27'::timestamp AND b.Date<='2014-09-09 13:24:28'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2011-01-08 03:03:48'::timestamp AND ph.CreationDate<='2014-08-25 14:04:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Reputation<=705 AND u.CreationDate>='2010-07-28 23:56:00'::timestamp AND u.CreationDate<='2014-09-02 10:04:41'::timestamp AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=89 AND p.CreationDate<='2014-09-02 10:21:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-07-20 20:47:27'::timestamp AND b.Date<='2014-09-09 13:24:28'::timestamp AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=89 AND p.CreationDate<='2014-09-02 10:21:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE b.UserId = u.Id AND b.Date>='2010-07-20 20:47:27'::timestamp AND b.Date<='2014-09-09 13:24:28'::timestamp AND u.Reputation<=705 AND u.CreationDate>='2010-07-28 23:56:00'::timestamp AND u.CreationDate<='2014-09-02 10:04:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.Reputation<=705 AND u.CreationDate>='2010-07-28 23:56:00'::timestamp AND u.CreationDate<='2014-09-02 10:04:41'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2011-01-08 03:03:48'::timestamp AND ph.CreationDate<='2014-08-25 14:04:43'::timestamp AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=89 AND p.CreationDate<='2014-09-02 10:21:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-07-20 20:47:27'::timestamp AND b.Date<='2014-09-09 13:24:28'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2011-01-08 03:03:48'::timestamp AND ph.CreationDate<='2014-08-25 14:04:43'::timestamp AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=89 AND p.CreationDate<='2014-09-02 10:21:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-07-20 20:47:27'::timestamp AND b.Date<='2014-09-09 13:24:28'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2011-01-08 03:03:48'::timestamp AND ph.CreationDate<='2014-08-25 14:04:43'::timestamp AND u.Reputation<=705 AND u.CreationDate>='2010-07-28 23:56:00'::timestamp AND u.CreationDate<='2014-09-02 10:04:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-07-20 20:47:27'::timestamp AND b.Date<='2014-09-09 13:24:28'::timestamp AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=89 AND p.CreationDate<='2014-09-02 10:21:04'::timestamp AND u.Reputation<=705 AND u.CreationDate>='2010-07-28 23:56:00'::timestamp AND u.CreationDate<='2014-09-02 10:04:41'::timestamp;

-- count: 1116000
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u, badges as b WHERE b.UserId = u.Id AND p.OwnerUserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2011-01-08 03:03:48'::timestamp AND ph.CreationDate<='2014-08-25 14:04:43'::timestamp AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=89 AND p.CreationDate<='2014-09-02 10:21:04'::timestamp AND u.Reputation<=705 AND u.CreationDate>='2010-07-28 23:56:00'::timestamp AND u.CreationDate<='2014-09-02 10:04:41'::timestamp AND b.Date>='2010-07-20 20:47:27'::timestamp AND b.Date<='2014-09-09 13:24:28'::timestamp;

-- count: 11206879551

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.PostTypeId=2 AND ph.CreationDate>='2010-07-27 18:08:19'::timestamp AND ph.CreationDate<='2014-09-10 08:22:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND ph.CreationDate>='2010-07-27 18:08:19'::timestamp AND ph.CreationDate<='2014-09-10 08:22:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-07-27 18:08:19'::timestamp AND ph.CreationDate<='2014-09-10 08:22:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND p.PostTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.PostTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-07-27 18:08:19'::timestamp AND ph.CreationDate<='2014-09-10 08:22:43'::timestamp AND p.PostTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-07-27 18:08:19'::timestamp AND ph.CreationDate<='2014-09-10 08:22:43'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.PostTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND p.CreationDate<='2014-09-03 03:32:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.CreationDate<='2014-09-12 22:21:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.CreationDate<='2014-09-12 22:21:49'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND p.CreationDate<='2014-09-03 03:32:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND p.CreationDate<='2014-09-03 03:32:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE b.UserId = u.Id AND u.CreationDate<='2014-09-12 22:21:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.CreationDate<='2014-09-12 22:21:49'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND p.CreationDate<='2014-09-03 03:32:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND p.CreationDate<='2014-09-03 03:32:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND u.CreationDate<='2014-09-12 22:21:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND p.CreationDate<='2014-09-03 03:32:35'::timestamp AND u.CreationDate<='2014-09-12 22:21:49'::timestamp;

-- count: 154355934
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u, badges as b WHERE b.UserId = u.Id AND p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND p.CreationDate<='2014-09-03 03:32:35'::timestamp AND u.CreationDate<='2014-09-12 22:21:49'::timestamp;

-- count: 6351775

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE u.Id = v.UserId AND u.Id = ph.UserId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.DownVotes>=0 AND u.DownVotes<=3 AND u.UpVotes>=0 AND u.UpVotes<=71;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-19 21:54:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.DownVotes>=0 AND u.DownVotes<=3 AND u.UpVotes>=0 AND u.UpVotes<=71 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date>='2010-07-19 21:54:06'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND b.Date>='2010-07-19 21:54:06'::timestamp AND u.DownVotes>=0 AND u.DownVotes<=3 AND u.UpVotes>=0 AND u.UpVotes<=71;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE u.Id = v.UserId AND u.Id = ph.UserId AND u.DownVotes>=0 AND u.DownVotes<=3 AND u.UpVotes>=0 AND u.UpVotes<=71 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-19 21:54:06'::timestamp AND u.DownVotes>=0 AND u.DownVotes<=3 AND u.UpVotes>=0 AND u.UpVotes<=71;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date>='2010-07-19 21:54:06'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND u.DownVotes>=0 AND u.DownVotes<=3 AND u.UpVotes>=0 AND u.UpVotes<=71;

-- count: 6351775
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, votes as v, users as u, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = v.UserId AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND u.DownVotes>=0 AND u.DownVotes<=3 AND u.UpVotes>=0 AND u.UpVotes<=71 AND b.Date>='2010-07-19 21:54:06'::timestamp;

-- count: 56205

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE u.Id = v.UserId AND u.Id = ph.UserId AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Reputation<=126 AND u.Views<=11 AND u.CreationDate>='2010-08-02 16:17:58'::timestamp AND u.CreationDate<='2014-09-12 00:16:30'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-03 16:13:12'::timestamp AND ph.PostHistoryTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Reputation<=126 AND u.Views<=11 AND u.CreationDate>='2010-08-02 16:17:58'::timestamp AND u.CreationDate<='2014-09-12 00:16:30'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-03 16:13:12'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND b.Date<='2014-09-03 16:13:12'::timestamp AND u.Reputation<=126 AND u.Views<=11 AND u.CreationDate>='2010-08-02 16:17:58'::timestamp AND u.CreationDate<='2014-09-12 00:16:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE u.Id = v.UserId AND u.Id = ph.UserId AND u.Reputation<=126 AND u.Views<=11 AND u.CreationDate>='2010-08-02 16:17:58'::timestamp AND u.CreationDate<='2014-09-12 00:16:30'::timestamp AND ph.PostHistoryTypeId=1 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-03 16:13:12'::timestamp AND ph.PostHistoryTypeId=1 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-03 16:13:12'::timestamp AND ph.PostHistoryTypeId=1 AND u.Reputation<=126 AND u.Views<=11 AND u.CreationDate>='2010-08-02 16:17:58'::timestamp AND u.CreationDate<='2014-09-12 00:16:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-03 16:13:12'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND u.Reputation<=126 AND u.Views<=11 AND u.CreationDate>='2010-08-02 16:17:58'::timestamp AND u.CreationDate<='2014-09-12 00:16:30'::timestamp;

-- count: 56205
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, votes as v, users as u, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = v.UserId AND ph.PostHistoryTypeId=1 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND u.Reputation<=126 AND u.Views<=11 AND u.CreationDate>='2010-08-02 16:17:58'::timestamp AND u.CreationDate<='2014-09-12 00:16:30'::timestamp AND b.Date<='2014-09-03 16:13:12'::timestamp;

-- count: 3136348028

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE u.Id = v.UserId AND u.Id = ph.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Views>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE u.Id = v.UserId AND u.Views>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND u.Views>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE u.Id = v.UserId AND u.Id = ph.UserId AND u.Views>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Views>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Views>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=2 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp AND c.Score=0 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND c.Score=0 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND c.Score=0 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND c.Score=0 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

-- count: 490921
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Id = c.PostId AND c.Score=0 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp AND v.VoteTypeId=2;

-- count: 454094

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

-- count: 454094
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Id = c.PostId AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

-- count: 914210

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp AND c.CreationDate<='2014-09-10 02:42:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND c.CreationDate<='2014-09-10 02:42:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate<='2014-09-10 02:42:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND c.CreationDate<='2014-09-10 02:42:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=2 AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND c.CreationDate<='2014-09-10 02:42:35'::timestamp AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate<='2014-09-10 02:42:35'::timestamp AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND c.CreationDate<='2014-09-10 02:42:35'::timestamp AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate<='2014-09-10 02:42:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND c.CreationDate<='2014-09-10 02:42:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND c.CreationDate<='2014-09-10 02:42:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate<='2014-09-10 02:42:35'::timestamp AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND c.CreationDate<='2014-09-10 02:42:35'::timestamp AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND c.CreationDate<='2014-09-10 02:42:35'::timestamp AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND c.CreationDate<='2014-09-10 02:42:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

-- count: 914210
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Id = c.PostId AND c.CreationDate<='2014-09-10 02:42:35'::timestamp AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp AND v.VoteTypeId=2;

-- count: 35205

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE c.PostId = p.Id AND p.CommentCount>=0 AND p.CommentCount<=14 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.RelatedPostId = p.Id AND c.PostId = p.Id AND pl.LinkTypeId=1 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id= c.UserId AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE pl.RelatedPostId = p.Id AND pl.LinkTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE ph.PostId = p.Id AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE pl.RelatedPostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE pl.RelatedPostId = p.Id AND c.PostId = p.Id AND pl.LinkTypeId=1 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.PostId = p.Id AND u.Id= c.UserId AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE pl.RelatedPostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE pl.RelatedPostId = p.Id AND c.PostId = p.Id AND u.Id= c.UserId AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE c.PostId = p.Id AND u.Id= c.UserId AND ph.PostId = p.Id AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE pl.RelatedPostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE pl.RelatedPostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE pl.RelatedPostId = p.Id AND c.PostId = p.Id AND u.Id= c.UserId AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE c.PostId = p.Id AND u.Id= c.UserId AND ph.PostId = p.Id AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE pl.RelatedPostId = p.Id AND c.PostId = p.Id AND u.Id= c.UserId AND ph.PostId = p.Id AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND pl.LinkTypeId=1 AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp;

-- count: 35205
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE pl.RelatedPostId = p.Id AND u.Id= c.UserId AND c.PostId = p.Id AND ph.PostId = p.Id AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.LinkTypeId=1 AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0;

-- count: 2863626

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND c.Score=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp AND c.Score=2 AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND p.OwnerUserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp AND c.Score=2 AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND c.Score=2 AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp AND c.Score=2 AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND c.Score=2 AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND c.Score=2 AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND p.OwnerUserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp AND c.Score=2 AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND c.Score=2 AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND p.OwnerUserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND c.Score=2 AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND c.Score=2 AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp;

-- count: 2863626
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE v.UserId = u.Id AND c.UserId = u.Id AND p.OwnerUserId = u.Id AND ph.UserId = u.Id AND c.Score=2 AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp;

-- count: 96484

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.Views>=0 AND u.Views<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE p.OwnerUserId = u.Id AND u.Views>=0 AND u.Views<=13 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, users as u WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND p.OwnerUserId = u.Id AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph, users as u WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND p.OwnerUserId = u.Id AND u.Views>=0 AND u.Views<=13 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=13 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

-- count: 96484
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE v.UserId = u.Id AND c.UserId = u.Id AND p.OwnerUserId = u.Id AND ph.UserId = u.Id AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND u.Views>=0 AND u.Views<=13;

-- count: 13971410

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE c.UserId = u.Id AND ph.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE ph.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, badges as b, users as u WHERE v.UserId = u.Id AND b.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v WHERE v.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, badges as b, users as u WHERE c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, badges as b, users as u WHERE v.UserId = u.Id AND ph.UserId = u.Id AND b.UserId = u.Id AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE b.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b, votes as v WHERE v.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE c.UserId = u.Id AND ph.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b, votes as v WHERE v.UserId = u.Id AND ph.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

-- count: 13971410
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph, badges as b, votes as v, users as u WHERE ph.UserId = u.Id AND v.UserId = u.Id AND c.UserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-09-26 12:17:14'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp;

-- count: 16698

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp AND c.Score=0 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND c.Score=0 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND c.Score=0 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND c.Score=0 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND c.Score=0 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND c.Score=0 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND c.Score=0 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

-- count: 16698
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, badges as b, users as u WHERE u.Id = ph.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND u.Id = c.UserId AND c.Score=0 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60;

-- count: 2263957167

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND c.Score=0 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND c.Score=0 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND c.Score=0 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND c.Score=0 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND c.Score=0 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=4157 AND p.FavoriteCount=0 AND p.CreationDate<='2014-09-08 09:58:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = ph.UserId AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE u.Id = c.UserId AND u.Id = b.UserId AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE u.Id = c.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, users as u WHERE u.Id = b.UserId AND u.Id = ph.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph WHERE u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE u.Id = c.UserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, badges as b WHERE u.Id = b.UserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

-- count: 255355807
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, badges as b, users as u WHERE u.Id = ph.UserId AND u.Id = b.UserId AND u.Id = p.OwnerUserId AND u.Id = c.UserId AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123;

-- count: 233930

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp AND c.CreationDate<='2014-09-13 20:12:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp AND c.CreationDate<='2014-09-13 20:12:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postLinks as pl, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

-- count: 233930
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postLinks as pl, posts as p, users as u, badges as b WHERE u.Id = b.UserId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

-- count: 15677331

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, posts as p, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, tags as t WHERE p.Id = t.ExcerptPostId AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, users as u WHERE u.Id = v.UserId AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u WHERE u.Id = b.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, tags as t, posts as p WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Reputation>=1 AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.CommentCount>=0 AND p.CommentCount<=13 AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, users as u, votes as v WHERE u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.CommentCount>=0 AND p.CommentCount<=13 AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, votes as v, users as u WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u, votes as v WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND u.Reputation>=1;

-- count: 15677331
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM tags as t, posts as p, users as u, votes as v, badges as b WHERE u.Id = b.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND p.Id = t.ExcerptPostId AND p.CommentCount>=0 AND p.CommentCount<=13 AND u.Reputation>=1 AND b.Date<='2014-09-06 17:33:22'::timestamp;

-- count: 4231593

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.DownVotes>=0 AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.Id = b.UserId AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND p.Score>=-1 AND p.Score<=14 AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.Id = b.UserId AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND p.Score>=-1 AND p.Score<=14 AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Id = b.UserId AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND v.CreationDate>='2009-02-02 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v, badges as b WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

-- count: 4231593
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, votes as v, badges as b, users as u WHERE u.Id = p.OwnerUserId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = c.PostId AND u.Id = b.UserId AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp AND u.DownVotes>=0;

-- count: 113925678

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.Score=0 AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, badges as b, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = ph.PostId AND c.Score=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

-- count: 113925678
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b, users as u WHERE p.Id = pl.RelatedPostId AND b.UserId = u.Id AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

-- count: 312148706

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.LinkTypeId=1 AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, badges as b, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId;

-- count: 312148706
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b, users as u WHERE p.Id = pl.RelatedPostId AND b.UserId = u.Id AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

-- count: 299574955

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, badges as b, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

-- count: 299574955
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b, users as u WHERE p.Id = pl.RelatedPostId AND b.UserId = u.Id AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

-- count: 155696936

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c WHERE c.UserId = u.Id AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND pl.LinkTypeId=1 AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE b.UserId = u.Id AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, posts as p WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, votes as v, users as u, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, badges as b, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1 AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b, posts as p WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b, posts as p WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = c.PostId AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE p.Id = c.PostId AND c.UserId = u.Id AND b.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, postHistory as ph, votes as v, users as u, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1 AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

-- count: 155696936
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b, users as u WHERE p.Id = pl.RelatedPostId AND b.UserId = u.Id AND c.UserId = u.Id AND p.Id = v.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

-- count: 18762969

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postLinks as pl, postHistory as ph, votes as v, badges as b, posts as p WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND b.Date<='2014-08-02 12:24:29'::timestamp AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-11 21:46:02'::timestamp AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND b.Date<='2014-09-11 21:46:02'::timestamp AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND b.Date<='2014-09-11 21:46:02'::timestamp AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND b.Date<='2014-09-11 21:46:02'::timestamp AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND b.Date<='2014-09-11 21:46:02'::timestamp AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, votes as v, users as u WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND b.Date<='2014-09-11 21:46:02'::timestamp AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND b.Date<='2014-09-11 21:46:02'::timestamp AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.Date<='2014-09-11 21:46:02'::timestamp AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

-- count: 18762969
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, badges as b, users as u WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = c.PostId AND u.Id = b.UserId AND p.Id = ph.PostId AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0;

-- count: 436286

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.PostHistoryTypeId=5 AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND ph.PostHistoryTypeId=5 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = pl.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND ph.PostHistoryTypeId=5 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

-- count: 436286
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp;

-- count: 1570429

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c WHERE p.Id = c.PostId AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND c.CreationDate>='2010-07-26 19:37:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND c.CreationDate>='2010-07-26 19:37:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp AND c.CreationDate>='2010-07-26 19:37:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, posts as p WHERE p.Id = pl.PostId AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p WHERE p.Id = ph.PostId AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p WHERE p.Id = v.PostId AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p WHERE u.Id = p.OwnerUserId AND u.DownVotes>=0 AND u.UpVotes>=0 AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postHistory as ph, posts as p WHERE p.Id = v.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postLinks as pl, comments as c, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, postLinks as pl, posts as p WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND u.DownVotes>=0 AND u.UpVotes>=0 AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postHistory as ph WHERE p.Id = v.PostId AND p.Id = ph.PostId AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postHistory as ph WHERE p.Id = c.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, postLinks as pl, postHistory as ph, posts as p WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = ph.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, votes as v WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = pl.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE p.Id = pl.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;

-- count: 1570429
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, users as u WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp AND u.DownVotes>=0 AND u.UpVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, badges as b WHERE u.Id = b.UserId AND u.UpVotes>=0;

-- count: 10220614
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, badges as b WHERE c.UserId = b.UserId AND c.Score=0 AND b.Date<='2014-09-11 14:33:06'::timestamp;

-- count: 1458075

-- count: 1458075
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph WHERE c.UserId = ph.UserId AND c.Score=0 AND ph.PostHistoryTypeId=1;

-- count: 1709781

-- count: 1709781
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postHistory as ph WHERE c.UserId = ph.UserId AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-09-14 11:59:07'::timestamp;

-- count: 7491903

-- count: 7491903
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, votes as v WHERE c.UserId = v.UserId AND c.Score=0;

-- count: 428612

-- count: 428612
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, posts as p WHERE b.UserId = p.OwnerUserId AND b.Date<='2014-09-11 08:55:52'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=17;

-- count: 699302

-- count: 699302
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl WHERE c.UserId = p.OwnerUserId AND p.Id = pl.PostId AND p.CommentCount<=18 AND p.CreationDate>='2010-07-23 07:27:31'::timestamp AND p.CreationDate<='2014-09-09 01:43:00'::timestamp;

-- count: 481420

-- count: 481420
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl WHERE c.UserId = p.OwnerUserId AND p.Id = pl.PostId AND c.Score=0 AND p.CreationDate>='2010-09-06 00:58:21'::timestamp AND p.CreationDate<='2014-09-12 10:02:21'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-07-09 22:35:44'::timestamp;

-- count: 698213

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, comments as c, posts as p WHERE p.Id = c.PostId AND p.Id = ph.PostId AND p.CommentCount>=0 AND p.CommentCount<=25;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND c.CreationDate>='2010-08-05 00:36:02'::timestamp AND c.CreationDate<='2014-09-08 16:50:49'::timestamp AND p.ViewCount>=0 AND p.ViewCount<=2897 AND p.CommentCount>=0 AND p.CommentCount<=16 AND p.FavoriteCount>=0 AND p.FavoriteCount<=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-08-23 16:21:10'::timestamp AND u.CreationDate<='2014-09-02 09:50:06'::timestamp AND c.Score=0 AND p.Score>=0 AND p.Score<=15 AND p.ViewCount>=0 AND p.ViewCount<=3002 AND p.AnswerCount<=3 AND p.CommentCount<=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=487 AND u.UpVotes<=27 AND u.CreationDate>='2010-10-22 22:40:35'::timestamp AND u.CreationDate<='2014-09-10 17:01:31'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.Reputation<=691 AND c.CreationDate>='2010-08-10 17:55:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.UpVotes=0 AND u.CreationDate<='2014-09-12 03:25:34'::timestamp AND c.CreationDate>='2010-10-01 20:45:26'::timestamp AND c.CreationDate<='2014-09-05 12:51:17'::timestamp AND v.BountyAmount<=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND u.UpVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-07-24 06:46:49'::timestamp AND b.Date>='2010-07-19 20:34:06'::timestamp AND b.Date<='2014-09-12 15:11:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=17 AND u.CreationDate>='2010-08-06 07:03:05'::timestamp AND u.CreationDate<='2014-09-08 04:18:44'::timestamp AND c.Score=0 AND b.Date>='2010-07-19 20:54:06'::timestamp;

-- count: 70752
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, tags as t, votes as v WHERE p.Id = t.ExcerptPostId AND p.OwnerUserId = v.UserId AND p.CreationDate>='2010-07-20 02:01:05'::timestamp;

-- count: 63500

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM postHistory as ph, posts as p, postLinks as pl WHERE pl.PostId = p.Id AND ph.PostId = p.Id AND ph.CreationDate>='2010-07-20 00:30:00'::timestamp AND p.CreationDate>='2010-07-19 20:08:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl WHERE p.OwnerUserId = u.Id AND p.Id = pl.PostId AND u.CreationDate<='2014-09-12 07:12:16'::timestamp AND p.CommentCount<=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.PostId = p.Id AND u.Reputation>=1 AND u.Reputation<=6524 AND u.Views>=0 AND ph.CreationDate<='2014-08-17 21:24:11'::timestamp AND p.CreationDate>='2010-07-26 19:26:37'::timestamp AND p.CreationDate<='2014-08-22 14:43:39'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE v.UserId = u.Id AND v.PostId = p.Id AND u.UpVotes>=0 AND u.CreationDate>='2010-07-27 17:15:57'::timestamp AND u.CreationDate<='2014-09-03 12:47:42'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.Score>=-1 AND p.CreationDate>='2010-10-21 13:21:24'::timestamp AND p.CreationDate<='2014-09-09 15:12:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND u.CreationDate>='2010-07-22 04:38:06'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE v.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, badges as b WHERE v.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes=0 AND v.BountyAmount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl WHERE pl.PostId = p.Id AND c.PostId = p.Id AND v.PostId = p.Id AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND c.CreationDate>='2010-08-02 23:52:10'::timestamp AND p.Score>=-3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl WHERE p.OwnerUserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = c.PostId AND u.UpVotes>=0 AND u.CreationDate>='2010-08-21 21:27:38'::timestamp AND c.CreationDate>='2010-07-21 11:05:37'::timestamp AND c.CreationDate<='2014-08-25 17:59:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.Id = p.OwnerUserId AND u.UpVotes>=0 AND u.UpVotes<=12 AND u.CreationDate>='2010-07-19 19:09:39'::timestamp AND c.Score=0 AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND p.CreationDate>='2010-07-27 01:51:15'::timestamp AND v.BountyAmount<=50 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.Reputation>=1 AND p.Score<=22;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND u.DownVotes<=2 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-26 03:34:11'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND p.PostTypeId=1 AND p.Score>=-1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=20 AND b.Date>='2010-07-20 19:02:22'::timestamp AND b.Date<='2014-09-03 23:36:09'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND p.Score>=0 AND p.Score<=30 AND p.CommentCount=0 AND p.CreationDate>='2010-07-27 15:30:31'::timestamp AND p.CreationDate<='2014-09-04 17:45:10'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-11-16 06:03:04'::timestamp AND v.CreationDate<='2014-09-06 00:00:00'::timestamp AND p.Score<=48 AND p.AnswerCount<=8 AND b.Date>='2011-01-03 20:50:19'::timestamp AND b.Date<='2014-09-02 15:35:07'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.Views<=783 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-12 20:33:46'::timestamp AND c.CreationDate<='2014-09-13 19:26:55'::timestamp AND ph.CreationDate>='2011-04-11 14:46:09'::timestamp AND ph.CreationDate<='2014-08-17 16:37:23'::timestamp AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.Views<=110 AND u.UpVotes=0 AND u.CreationDate>='2010-07-28 19:29:11'::timestamp AND u.CreationDate<='2014-08-14 05:29:30'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp AND v.CreationDate<='2014-09-08 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.DownVotes<=57 AND u.CreationDate>='2010-08-26 09:01:31'::timestamp AND u.CreationDate<='2014-08-10 11:01:39'::timestamp AND c.Score=0 AND v.BountyAmount>=0 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.UpVotes>=0 AND u.UpVotes<=18 AND c.Score=0 AND v.BountyAmount>=0 AND v.BountyAmount<=300 AND v.CreationDate>='2010-07-29 00:00:00'::timestamp;

-- count: 1633681
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = c.PostId AND c.PostId = ph.PostId AND ph.PostId = v.PostId AND ph.CreationDate>='2011-05-07 21:47:19'::timestamp AND ph.CreationDate<='2014-09-10 13:19:54'::timestamp;

-- count: 105742741

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND c.Score=0 AND c.CreationDate>='2010-09-05 16:04:35'::timestamp AND c.CreationDate<='2014-09-11 04:35:36'::timestamp AND ph.PostHistoryTypeId=1 AND ph.CreationDate>='2010-07-26 20:01:58'::timestamp AND ph.CreationDate<='2014-09-13 17:29:23'::timestamp AND b.Date<='2014-09-04 08:54:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=356 AND u.DownVotes<=34 AND u.CreationDate>='2010-07-19 21:29:29'::timestamp AND u.CreationDate<='2014-08-20 14:31:46'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 10:52:57'::timestamp AND ph.PostHistoryTypeId=5 AND ph.CreationDate>='2011-01-31 15:35:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND pl.LinkTypeId=1 AND p.Score>=-1 AND p.CommentCount<=8 AND p.CreationDate>='2010-07-21 12:30:43'::timestamp AND p.CreationDate<='2014-09-07 01:11:03'::timestamp AND u.Views<=40 AND u.CreationDate>='2010-07-26 19:11:25'::timestamp AND u.CreationDate<='2014-09-11 22:26:42'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postLinks as pl, posts as p, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND b.Date<='2014-09-10 22:50:06'::timestamp AND pl.CreationDate<='2014-08-17 01:23:50'::timestamp AND p.Score>=-1 AND p.Score<=10 AND p.AnswerCount<=5 AND p.CommentCount=2 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND u.Views<=33 AND u.DownVotes>=0 AND u.CreationDate>='2010-08-19 17:31:36'::timestamp AND u.CreationDate<='2014-08-06 07:23:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND p.PostTypeId=1 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND ph.PostHistoryTypeId=3 AND p.Score>=-7 AND u.Reputation>=1 AND u.UpVotes>=0 AND u.UpVotes<=117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND ph.CreationDate>='2010-09-06 11:41:43'::timestamp AND ph.CreationDate<='2014-09-03 16:41:18'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.ViewCount<=39097 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=10 AND p.CreationDate>='2010-08-13 02:18:09'::timestamp AND p.CreationDate<='2014-09-09 10:20:27'::timestamp AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=37;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-19 19:39:10'::timestamp AND b.Date<='2014-09-05 18:37:48'::timestamp AND ph.PostHistoryTypeId=2 AND u.Views=5 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=224 AND u.CreationDate<='2014-09-04 04:41:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = v.PostId AND p.Id = pl.PostId AND p.Id = c.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

-- count: 60601561
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postHistory as ph, votes as v, users as u WHERE u.Id = c.UserId AND c.UserId = p.OwnerUserId AND p.OwnerUserId = ph.UserId AND ph.UserId = v.UserId AND p.Score<=13 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=3 AND v.BountyAmount<=50 AND u.DownVotes>=0;

-- count: 224

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b, votes as v WHERE c.UserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND v.UserId = u.Id AND u.UpVotes=0 AND c.CreationDate>='2010-07-20 21:37:31'::timestamp AND ph.PostHistoryTypeId=12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes<=11 AND u.CreationDate>='2010-07-31 17:32:56'::timestamp AND u.CreationDate<='2014-09-07 16:06:26'::timestamp AND c.Score=1 AND p.Score>=-1 AND p.Score<=29 AND p.CreationDate>='2010-07-19 20:40:36'::timestamp AND p.CreationDate<='2014-09-10 20:52:30'::timestamp AND v.BountyAmount<=50 AND b.Date<='2014-08-25 19:05:46'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v, badges as b WHERE p.OwnerUserId = u.Id AND c.UserId = u.Id AND v.UserId = u.Id AND b.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=113 AND u.Views>=0 AND u.Views<=51 AND c.Score=1 AND p.Score>=-2 AND p.Score<=23 AND p.ViewCount<=2432 AND p.CommentCount=0 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = p.OwnerUserId AND u.Views>=0 AND u.Views<=75 AND c.CreationDate>='2010-07-31 05:18:59'::timestamp AND c.CreationDate<='2014-09-12 07:59:13'::timestamp AND p.Score>=-2 AND p.ViewCount>=0 AND p.ViewCount<=18281 AND ph.PostHistoryTypeId=2 AND b.Date>='2010-10-20 08:33:44'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Id = p.OwnerUserId AND u.Views<=233 AND u.DownVotes<=2 AND u.CreationDate>='2010-09-16 16:00:55'::timestamp AND u.CreationDate<='2014-08-24 21:12:02'::timestamp AND p.PostTypeId=1 AND p.Score<=35 AND p.AnswerCount=1 AND p.CommentCount<=17 AND p.FavoriteCount>=0 AND b.Date>='2010-07-27 17:58:45'::timestamp AND b.Date<='2014-09-06 17:33:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, posts as p, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.CreationDate<='2014-09-08 15:58:08'::timestamp AND p.ViewCount>=0 AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, posts as p, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-04-12 15:23:59'::timestamp AND p.Score=1 AND p.ViewCount>=0 AND p.FavoriteCount>=0 AND u.CreationDate>='2011-02-08 18:11:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u, postHistory as ph WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND b.Date<='2014-08-22 02:21:55'::timestamp AND p.CommentCount>=0 AND u.DownVotes<=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u, votes as v WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.DownVotes>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u, votes as v WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-12 12:56:22'::timestamp AND u.Views>=0 AND u.Views<=515 AND u.UpVotes>=0 AND u.CreationDate<='2014-09-07 13:46:41'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND p.Id = pl.RelatedPostId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes<=439 AND u.CreationDate<='2014-08-07 11:18:45'::timestamp AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND ph.PostHistoryTypeId=2 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Views<=190 AND u.CreationDate>='2010-07-20 08:05:39'::timestamp AND u.CreationDate<='2014-08-27 09:31:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2011-02-17 03:42:02'::timestamp AND u.CreationDate<='2014-09-01 10:54:39'::timestamp AND c.CreationDate>='2010-08-06 12:21:39'::timestamp AND c.CreationDate<='2014-09-11 20:55:34'::timestamp AND p.Score>=0 AND p.Score<=13 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-11 18:50:29'::timestamp AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.UpVotes>=0 AND c.Score=2 AND p.ViewCount<=7710 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=4 AND p.CreationDate>='2010-07-27 03:58:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.Views<=160 AND u.CreationDate>='2010-07-27 12:58:30'::timestamp AND u.CreationDate<='2014-07-12 20:08:07'::timestamp AND c.Score=0 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CreationDate<='2014-09-12 15:56:19'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-03-07 16:05:24'::timestamp AND v.BountyAmount<=100 AND v.CreationDate>='2009-02-03 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND c.CreationDate<='2014-09-11 13:24:22'::timestamp AND p.PostTypeId=1 AND p.Score=2 AND p.FavoriteCount<=12 AND pl.CreationDate>='2010-08-13 11:42:08'::timestamp AND pl.CreationDate<='2014-08-29 00:27:05'::timestamp AND ph.CreationDate>='2011-01-03 23:47:35'::timestamp AND ph.CreationDate<='2014-09-08 12:48:36'::timestamp AND v.CreationDate>='2010-07-27 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-09-18 01:58:41'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-20 06:26:28'::timestamp AND c.CreationDate<='2014-09-11 18:45:09'::timestamp AND p.PostTypeId=1 AND p.FavoriteCount>=0 AND p.FavoriteCount<=2 AND ph.PostHistoryTypeId=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate<='2014-08-19 21:33:14'::timestamp AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 01:26:16'::timestamp AND p.Score>=-1 AND p.Score<=19 AND p.CommentCount<=13 AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-07 12:06:00'::timestamp AND v.BountyAmount<=50 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE u.Id = c.UserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND u.Id = v.UserId AND u.Reputation<=270 AND u.Views>=0 AND u.Views<=51 AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-08-02 20:27:48'::timestamp AND c.CreationDate<='2014-09-10 16:09:23'::timestamp AND p.PostTypeId=1 AND p.Score=4 AND p.ViewCount<=4937 AND pl.CreationDate>='2011-11-03 05:09:35'::timestamp AND ph.PostHistoryTypeId=1;

-- count: 1112747282
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.UserId = c.UserId AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

-- count: 107654752

-- count: 107654752
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.UserId = c.UserId AND c.Score=0 AND p.Score<=32 AND p.ViewCount<=4146 AND pl.LinkTypeId=1 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

-- count: 80052528

-- count: 80052528
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.UserId = c.UserId AND c.CreationDate>='2010-07-26 20:21:15'::timestamp AND c.CreationDate<='2014-09-13 18:12:10'::timestamp AND p.Score<=61 AND p.ViewCount<=3627 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=8 AND p.FavoriteCount>=0 AND v.VoteTypeId=2 AND v.CreationDate>='2010-07-27 00:00:00'::timestamp AND b.Date>='2010-07-30 03:49:24'::timestamp;

-- count: 58623592

-- count: 58623592
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.UserId = c.UserId AND p.CommentCount>=0 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=5;

-- count: 1582060

-- count: 1582060
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.UserId = c.UserId AND c.Score=0 AND p.Score<=67 AND ph.PostHistoryTypeId=34 AND b.Date<='2014-08-20 12:16:56'::timestamp;

-- count: 1639421

-- count: 1639421
EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = ph.PostId AND p.Id = v.PostId AND b.UserId = c.UserId AND c.CreationDate>='2010-07-22 01:19:43'::timestamp AND p.Score>=-1 AND p.ViewCount>=0 AND p.CommentCount<=9 AND ph.CreationDate>='2010-09-20 17:45:15'::timestamp AND ph.CreationDate<='2014-08-07 01:00:45'::timestamp AND v.VoteTypeId=15;

-- count: 38686327

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.PostTypeId=1 AND p.Score<=192 AND p.ViewCount>=0 AND p.ViewCount<=2772 AND p.AnswerCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND u.Reputation<=312 AND u.DownVotes<=0 AND c.Score=0 AND c.CreationDate<='2014-09-09 19:58:29'::timestamp AND p.Score>=-4 AND p.ViewCount>=0 AND p.ViewCount<=5977 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2011-01-25 08:31:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND u.Views<=86 AND u.DownVotes>=0 AND u.DownVotes<=1 AND u.UpVotes<=6 AND p.PostTypeId=1 AND p.ViewCount<=4159 AND p.CommentCount>=0 AND p.CommentCount<=12 AND ph.PostHistoryTypeId=2 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Views>=0 AND u.CreationDate>='2010-08-19 06:26:34'::timestamp AND u.CreationDate<='2014-09-11 05:22:26'::timestamp AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.FavoriteCount>=0 AND p.FavoriteCount<=17 AND v.VoteTypeId=5 AND b.Date>='2010-08-01 02:54:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND v.BountyAmount<=50;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND u.Reputation<=240 AND c.Score=0 AND p.Score<=21 AND p.AnswerCount<=3 AND p.FavoriteCount>=0 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND b.Date<='2014-09-11 18:35:08'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND u.Reputation>=1 AND u.CreationDate>='2010-08-03 19:42:40'::timestamp AND u.CreationDate<='2014-09-12 02:20:03'::timestamp AND c.CreationDate>='2010-07-27 17:46:38'::timestamp AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.CreationDate>='2010-07-26 09:46:48'::timestamp AND p.CreationDate<='2014-09-13 10:09:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p WHERE c.UserId = u.Id AND u.Id = p.OwnerUserId AND u.Reputation>=1 AND c.Score=0 AND p.AnswerCount<=5 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount<=27;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Views<=80 AND u.UpVotes>=0 AND u.CreationDate>='2010-08-02 20:31:12'::timestamp AND c.CreationDate>='2010-08-09 07:24:50'::timestamp AND c.CreationDate<='2014-09-10 03:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph WHERE c.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Reputation<=7931 AND u.Views<=109 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 13:12:56'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.CreationDate<='2014-09-03 01:06:41'::timestamp AND c.CreationDate>='2010-07-27 15:46:34'::timestamp AND c.CreationDate<='2014-09-12 08:15:14'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v WHERE u.Id = c.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-07-19 20:11:48'::timestamp AND u.CreationDate<='2014-07-09 20:37:10'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, votes as v, users as u WHERE u.Id = c.UserId AND c.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND u.Views>=0 AND u.Views<=74;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND u.Views>=0 AND u.DownVotes>=0 AND u.DownVotes<=2 AND c.CreationDate>='2010-08-12 20:27:30'::timestamp AND c.CreationDate<='2014-09-12 12:49:19'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, badges as b WHERE c.UserId = u.Id AND b.UserId = u.Id AND u.UpVotes>=0 AND c.Score=0 AND c.CreationDate>='2010-07-24 06:46:49'::timestamp AND b.Date>='2010-07-19 20:34:06'::timestamp AND b.Date<='2014-09-12 15:11:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.DownVotes=0 AND u.UpVotes>=0 AND u.UpVotes<=244 AND p.Score>=-1 AND p.CommentCount>=0 AND p.CommentCount<=23;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.Views>=0 AND u.UpVotes>=0 AND u.CreationDate>='2010-11-27 21:46:49'::timestamp AND u.CreationDate<='2014-08-18 13:00:22'::timestamp AND ph.CreationDate>='2011-05-20 18:43:03'::timestamp AND p.FavoriteCount<=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.UpVotes<=198 AND u.CreationDate>='2010-07-19 20:49:05'::timestamp AND ph.CreationDate>='2010-08-21 05:30:40'::timestamp AND p.Score>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p WHERE p.OwnerUserId = u.Id AND ph.PostId = p.Id AND u.UpVotes>=0 AND u.UpVotes<=9 AND p.CreationDate>='2010-08-17 19:08:05'::timestamp AND p.CreationDate<='2014-08-31 06:58:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND u.Views>=0 AND p.PostTypeId=2 AND p.CreationDate<='2014-08-26 22:40:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p WHERE p.OwnerUserId = u.Id AND v.UserId = u.Id AND u.CreationDate>='2010-12-15 06:00:24'::timestamp AND p.CommentCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph, votes as v WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postHistory as ph, votes as v WHERE c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND c.CreationDate>='2010-08-26 06:55:11'::timestamp AND ph.CreationDate<='2014-09-05 06:39:25'::timestamp AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Views>=0 AND u.CreationDate>='2010-07-27 09:38:05'::timestamp AND c.CreationDate>='2010-07-27 12:03:40'::timestamp AND p.Score>=0 AND p.Score<=28 AND p.ViewCount>=0 AND p.ViewCount<=6517 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND p.FavoriteCount>=0 AND p.FavoriteCount<=8 AND p.CreationDate>='2010-07-27 11:29:20'::timestamp AND p.CreationDate<='2014-09-13 02:50:15'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.UpVotes>=0 AND u.CreationDate>='2010-10-05 05:52:35'::timestamp AND u.CreationDate<='2014-09-08 15:55:02'::timestamp AND p.Score<=52 AND p.AnswerCount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = v.UserId AND u.Reputation<=306 AND u.UpVotes>=0 AND c.Score=0 AND p.ViewCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.Reputation>=1 AND u.CreationDate>='2010-07-19 19:08:49'::timestamp AND u.CreationDate<='2014-08-28 12:15:56'::timestamp AND p.Score>=0 AND p.Score<=16 AND p.ViewCount>=0 AND p.CreationDate<='2014-09-09 12:00:50'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, votes as v WHERE p.Id = c.PostId AND u.Id = p.OwnerUserId AND p.Id = v.PostId AND u.DownVotes>=0 AND c.Score=0 AND c.CreationDate<='2014-09-10 02:47:53'::timestamp AND p.Score>=0 AND p.Score<=19 AND p.CommentCount<=10 AND p.CreationDate<='2014-08-28 13:31:33'::timestamp AND v.CreationDate<='2014-09-12 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = v.PostId AND p.AnswerCount>=0 AND p.AnswerCount<=7 AND p.CreationDate<='2014-09-12 00:03:32'::timestamp AND b.Date<='2014-09-11 07:27:36'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, votes as v, posts as p, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND u.DownVotes>=0 AND u.DownVotes<=1 AND p.PostTypeId=1 AND p.CommentCount>=0 AND p.CommentCount<=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=72 AND ph.CreationDate>='2010-07-28 09:11:34'::timestamp AND ph.CreationDate<='2014-09-06 06:51:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.Views<=433 AND u.DownVotes>=0 AND u.CreationDate<='2014-09-12 21:37:39'::timestamp AND c.Score=0 AND c.CreationDate>='2010-07-19 19:56:21'::timestamp AND c.CreationDate<='2014-09-11 13:36:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND u.Reputation>=1 AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=15 AND u.CreationDate>='2010-09-03 11:45:16'::timestamp AND u.CreationDate<='2014-08-18 17:19:53'::timestamp AND c.CreationDate<='2014-08-28 07:25:55'::timestamp AND ph.PostHistoryTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.Reputation>=1 AND c.Score=1 AND c.CreationDate>='2010-08-27 14:12:07'::timestamp AND v.VoteTypeId=5 AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-13 00:00:00'::timestamp AND b.Date<='2014-08-19 10:32:13'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, votes as v, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = v.UserId AND u.CreationDate>='2010-07-20 01:27:29'::timestamp AND c.Score=1 AND c.CreationDate>='2010-07-20 23:17:28'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-11-21 22:39:41'::timestamp AND pl.CreationDate<='2014-09-01 16:29:56'::timestamp AND v.CreationDate>='2010-07-22 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND c.Score=0 AND pl.CreationDate>='2011-03-22 06:18:34'::timestamp AND pl.CreationDate<='2014-08-22 20:04:25'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2010-10-19 15:02:42'::timestamp AND ph.CreationDate<='2014-06-18 17:14:07'::timestamp AND v.CreationDate>='2010-07-20 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM posts as p, comments as c, postLinks as pl, postHistory as ph, votes as v WHERE pl.PostId = p.Id AND c.PostId = p.Id AND ph.PostId = p.Id AND v.PostId = p.Id AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-06-14 13:31:35'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes<=47 AND c.CreationDate<='2014-09-10 00:33:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views>=0 AND u.DownVotes>=0 AND u.UpVotes>=0 AND u.UpVotes<=62 AND u.CreationDate>='2010-07-27 17:10:30'::timestamp AND u.CreationDate<='2014-07-31 18:48:36'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate<='2014-08-01 13:56:22'::timestamp AND b.Date<='2014-09-02 23:33:16'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=1443 AND u.DownVotes>=0 AND u.DownVotes<=3 AND c.CreationDate<='2014-08-28 00:18:24'::timestamp AND b.Date>='2010-09-15 02:50:48'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Reputation>=1 AND u.Reputation<=1183 AND u.Views>=0 AND c.Score=2 AND ph.CreationDate>='2010-08-19 12:45:55'::timestamp AND ph.CreationDate<='2014-09-03 21:46:37'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.Views>=0 AND u.Views<=34 AND u.UpVotes>=0 AND ph.CreationDate>='2010-07-21 00:44:08'::timestamp AND p.ViewCount>=0 AND p.CommentCount>=0 AND v.VoteTypeId=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, postHistory as ph, posts as p, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = v.PostId AND p.Id = ph.PostId AND u.DownVotes=0 AND u.CreationDate<='2014-08-08 07:03:29'::timestamp AND ph.CreationDate<='2014-07-28 13:25:35'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-03 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-07-20 10:34:10'::timestamp AND ph.PostHistoryTypeId=5 AND p.ViewCount>=0 AND p.ViewCount<=2024 AND u.Reputation>=1 AND u.Reputation<=750;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND b.Date>='2010-07-20 20:47:27'::timestamp AND b.Date<='2014-09-09 13:24:28'::timestamp AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2011-01-08 03:03:48'::timestamp AND ph.CreationDate<='2014-08-25 14:04:43'::timestamp AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=89 AND p.CreationDate<='2014-09-02 10:21:04'::timestamp AND u.Reputation<=705 AND u.CreationDate>='2010-07-28 23:56:00'::timestamp AND u.CreationDate<='2014-09-02 10:04:41'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, posts as p, users as u WHERE p.OwnerUserId = u.Id AND b.UserId = u.Id AND ph.UserId = u.Id AND p.AnswerCount>=0 AND p.FavoriteCount>=0 AND p.CreationDate<='2014-09-03 03:32:35'::timestamp AND u.CreationDate<='2014-09-12 22:21:49'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND b.Date>='2010-07-19 21:54:06'::timestamp AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND u.DownVotes>=0 AND u.DownVotes<=3 AND u.UpVotes>=0 AND u.UpVotes<=71;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, postHistory as ph, votes as v, users as u WHERE u.Id = b.UserId AND u.Id = v.UserId AND u.Id = ph.UserId AND b.Date<='2014-09-03 16:13:12'::timestamp AND ph.PostHistoryTypeId=1 AND v.CreationDate<='2014-09-12 00:00:00'::timestamp AND u.Reputation<=126 AND u.Views<=11 AND u.CreationDate>='2010-08-02 16:17:58'::timestamp AND u.CreationDate<='2014-09-12 00:16:30'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND c.Score=0 AND p.FavoriteCount>=0 AND p.CreationDate>='2010-07-23 02:00:12'::timestamp AND p.CreationDate<='2014-09-08 13:52:41'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-10-06 21:41:26'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.CreationDate<='2014-09-11 00:00:00'::timestamp AND c.CreationDate>='2010-08-01 12:12:41'::timestamp AND p.Score<=44 AND p.FavoriteCount>=0 AND p.FavoriteCount<=3 AND p.CreationDate>='2010-08-11 13:53:56'::timestamp AND p.CreationDate<='2014-09-03 11:52:36'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate<='2014-08-11 17:26:31'::timestamp AND ph.CreationDate>='2010-09-20 19:11:45'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM votes as v, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = v.PostId AND p.Id = ph.PostId AND v.VoteTypeId=2 AND c.CreationDate<='2014-09-10 02:42:35'::timestamp AND p.Score>=-1 AND p.ViewCount<=5896 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-29 15:57:21'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph WHERE pl.RelatedPostId = p.Id AND c.PostId = p.Id AND u.Id= c.UserId AND ph.PostId = p.Id AND u.Reputation>=1 AND u.Reputation<=491 AND u.DownVotes>=0 AND u.DownVotes<=0 AND c.CreationDate>='2010-07-11 12:25:05'::timestamp AND c.CreationDate<='2014-09-11 13:43:09'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.LinkTypeId=1 AND ph.CreationDate>='2010-08-06 03:14:53'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND p.OwnerUserId = u.Id AND u.UpVotes<=230 AND u.CreationDate>='2010-09-22 01:07:10'::timestamp AND u.CreationDate<='2014-08-15 05:52:23'::timestamp AND c.Score=2 AND p.AnswerCount>=0 AND p.AnswerCount<=9 AND p.CreationDate>='2010-07-20 18:17:25'::timestamp AND p.CreationDate<='2014-08-26 12:57:22'::timestamp AND ph.CreationDate<='2014-09-02 07:58:47'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-05-19 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND p.OwnerUserId = u.Id AND u.Views>=0 AND u.Views<=13 AND p.ViewCount>=0 AND p.AnswerCount>=0 AND p.AnswerCount<=5 AND ph.PostHistoryTypeId=2 AND ph.CreationDate>='2010-11-05 01:25:39'::timestamp AND ph.CreationDate<='2014-09-09 07:14:12'::timestamp AND v.BountyAmount>=0 AND v.BountyAmount<=100 AND v.CreationDate>='2010-07-26 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, postHistory as ph, badges as b, votes as v WHERE c.UserId = u.Id AND v.UserId = u.Id AND ph.UserId = u.Id AND b.UserId = u.Id AND u.DownVotes>=0 AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=31 AND u.CreationDate<='2014-08-06 20:38:52'::timestamp AND b.Date>='2010-09-26 12:17:14'::timestamp AND v.BountyAmount>=0 AND v.CreationDate>='2010-07-20 00:00:00'::timestamp AND v.CreationDate<='2014-09-11 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.Views=0 AND u.DownVotes>=0 AND u.DownVotes<=60 AND c.Score=0 AND p.Score>=-2 AND p.CommentCount>=0 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND p.FavoriteCount<=6 AND ph.CreationDate<='2014-08-18 08:54:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, badges as b WHERE u.Id = c.UserId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = ph.UserId AND u.DownVotes<=0 AND u.UpVotes>=0 AND u.UpVotes<=123 AND c.CreationDate>='2010-08-19 09:33:49'::timestamp AND c.CreationDate<='2014-08-28 06:54:21'::timestamp AND p.PostTypeId=1 AND p.ViewCount>=0 AND p.ViewCount<=25597 AND p.CommentCount>=0 AND p.CommentCount<=11 AND p.FavoriteCount>=0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, comments as c, postLinks as pl, posts as p, users as u WHERE p.Id = pl.RelatedPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND c.CreationDate<='2014-09-13 20:12:15'::timestamp AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-09-03 21:00:10'::timestamp AND pl.CreationDate<='2014-07-30 21:29:52'::timestamp AND p.Score>=0 AND p.Score<=23 AND p.AnswerCount>=0 AND p.AnswerCount<=4 AND p.CommentCount>=0 AND p.CommentCount<=10 AND p.FavoriteCount<=9 AND p.CreationDate>='2010-07-22 12:17:20'::timestamp AND p.CreationDate<='2014-09-12 00:27:12'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM badges as b, tags as t, posts as p, users as u, votes as v WHERE p.Id = t.ExcerptPostId AND u.Id = p.OwnerUserId AND u.Id = b.UserId AND u.Id = v.UserId AND b.Date<='2014-09-06 17:33:22'::timestamp AND p.CommentCount>=0 AND p.CommentCount<=13 AND u.Reputation>=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND u.DownVotes>=0 AND p.Score>=-1 AND p.Score<=14 AND pl.CreationDate<='2014-06-25 13:05:06'::timestamp AND v.CreationDate>='2009-02-02 00:00:00'::timestamp AND b.Date>='2010-08-04 08:50:31'::timestamp AND b.Date<='2014-09-02 02:51:22'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND p.ViewCount>=0 AND p.AnswerCount<=5 AND p.CommentCount<=12 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND pl.CreationDate>='2011-02-16 20:04:50'::timestamp AND pl.CreationDate<='2014-09-01 16:48:04'::timestamp AND v.CreationDate>='2010-07-19 00:00:00'::timestamp AND v.CreationDate<='2014-08-31 00:00:00'::timestamp AND b.Date>='2010-08-06 10:36:45'::timestamp AND b.Date<='2014-09-12 07:19:35'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND p.Score<=40 AND p.CommentCount>=0 AND p.CreationDate>='2010-07-28 17:40:56'::timestamp AND p.CreationDate<='2014-09-11 04:22:44'::timestamp AND pl.LinkTypeId=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.Score=0 AND c.CreationDate>='2010-07-26 17:09:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND p.CommentCount<=14 AND pl.CreationDate>='2010-10-27 10:02:57'::timestamp AND pl.CreationDate<='2014-09-04 17:23:50'::timestamp AND ph.CreationDate<='2014-09-11 20:09:41'::timestamp AND v.CreationDate>='2010-07-21 00:00:00'::timestamp AND v.CreationDate<='2014-09-14 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v, badges as b WHERE c.UserId = u.Id AND p.Id = c.PostId AND p.Id = ph.PostId AND b.UserId = u.Id AND p.Id = pl.RelatedPostId AND p.Id = v.PostId AND c.CreationDate>='2010-08-01 19:11:47'::timestamp AND c.CreationDate<='2014-09-11 13:42:51'::timestamp AND p.AnswerCount<=4 AND p.FavoriteCount>=0 AND pl.LinkTypeId=1 AND v.VoteTypeId=2 AND v.CreationDate<='2014-09-10 00:00:00'::timestamp AND b.Date<='2014-08-02 12:24:29'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postHistory as ph, votes as v, badges as b WHERE u.Id = p.OwnerUserId AND u.Id = b.UserId AND p.Id = c.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND u.Reputation>=1 AND u.Reputation<=642 AND u.DownVotes>=0 AND p.AnswerCount>=0 AND p.CommentCount>=0 AND b.Date<='2014-09-11 21:46:02'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND u.UpVotes>=0 AND u.CreationDate<='2014-09-11 20:31:48'::timestamp AND p.PostTypeId=1 AND p.AnswerCount>=0 AND p.CreationDate>='2010-07-21 15:23:53'::timestamp AND p.CreationDate<='2014-09-11 23:26:14'::timestamp AND pl.CreationDate>='2010-11-16 01:27:37'::timestamp AND pl.CreationDate<='2014-08-21 15:25:23'::timestamp AND ph.PostHistoryTypeId=5 AND v.CreationDate>='2010-07-21 00:00:00'::timestamp;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE)
SELECT * FROM users as u, comments as c, posts as p, postLinks as pl, postHistory as ph, votes as v WHERE u.Id = p.OwnerUserId AND p.Id = c.PostId AND p.Id = pl.PostId AND p.Id = ph.PostId AND p.Id = v.PostId AND u.DownVotes>=0 AND u.UpVotes>=0 AND c.CreationDate>='2010-07-26 19:37:03'::timestamp AND p.Score>=-2 AND p.CommentCount<=18 AND p.CreationDate>='2010-07-21 13:50:08'::timestamp AND p.CreationDate<='2014-09-11 00:53:10'::timestamp AND pl.CreationDate<='2014-08-05 18:27:51'::timestamp AND ph.CreationDate>='2010-11-27 03:38:45'::timestamp;
