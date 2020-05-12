import imdb
ia = imdb.IMDb()

with open("moviedb.txt", "a") as f:
    for movie in ia.get_top250_movies():
        ia.update(movie)
        print(movie['title'])
        f.write('\t'.join([
            movie['title'],
            str(movie['year']),
            str(movie['rating']),
            movie['runtimes'][0],
            movie['director'][0]['name'],
            movie['genres'][0]
            ])
        )
        f.write('\n')
