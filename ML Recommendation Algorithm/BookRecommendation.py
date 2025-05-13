# Importing required libraries
import numpy as np
import pandas as pd
import random
import pickle

#Loading Dataset
book = pd.read_csv('books.csv', low_memory=False)
user = pd.read_csv('users.csv')
rating = pd.read_csv('ratings.csv')

# Merging rating and book dataframes
rating_with_name = rating.merge(book, on='ISBN')

# Filtering users who have given ratings to at least 250 books
b = rating_with_name.groupby('User-ID').count()['Book-Rating'] > 250
users_with_ratings = b[b].index
filtered_rating = rating_with_name[rating_with_name['User-ID'].isin(users_with_ratings)]

# Filtering books that have ratings from at least 50 users
c = filtered_rating.groupby('Book-Title').count()['Book-Rating'] >= 50
famous_books = c[c].index
final_ratings = filtered_rating[filtered_rating['Book-Title'].isin(famous_books)]

# Creating a pivot table for collaborative filtering
pt = final_ratings.pivot_table(index='Book-Title', columns='User-ID', values='Book-Rating')
pt.fillna(0, inplace=True)

# Calculating cosine similarity for collaborative filtering
from sklearn.metrics.pairwise import cosine_similarity
similarity_scores = cosine_similarity(pt)

# Function to recommend similar books
def recommendation(book_name):
    if book_name not in pt.index:
        print(f"Book '{book_name}' not found in dataset.")
        return ""

    # Fetching index
    index = np.where(np.array(list(pt.index)) == book_name)[0][0]
    similar_items = sorted(list(enumerate(similarity_scores[index])), reverse=True, key=lambda x: x[1])[1:9]
    
    # Pick one at random
    selected = random.choice(similar_items)

    # Get book info
    temp_df = book[book['Book-Title'] == pt.index[selected[0]]].drop_duplicates('Book-Title')

    result = [
        "Title: " + str(temp_df['Book-Title'].values[0]),
        "Author: " + str (temp_df['Book-Author'].values[0]),
    ]
    return (result[0] + "\n" + result[1])

# Saving collaborative filtering data into pickle files
pickle.dump(pt, open('pt.pkl', 'wb'))
pickle.dump(book, open('book.pkl', 'wb'))
pickle.dump(similarity_scores, open('similarity_scores.pkl', 'wb'))

# results = recommendation("Apple")
# print(results)


import json

# Book titles list
book_titles = list(pt.index)

# Metadata mapping
book_metadata = {
    title: {
        "Book-Author": book[book['Book-Title'] == title]['Book-Author'].values[0],
        "Year-Of-Publication": int(book[book['Book-Title'] == title]['Year-Of-Publication'].values[0]),
        "Publisher": book[book['Book-Title'] == title]['Publisher'].values[0],
        "Image-URL-L": book[book['Book-Title'] == title]['Image-URL-L'].values[0]
    }
    for title in pt.index
    if not book[book['Book-Title'] == title].empty
}


# Convert similarity scores (numpy array) to list of lists
similarity_list = similarity_scores.tolist()

# Bundle data into one dictionary
data = {
    "book_titles": book_titles,
    "book_metadata": book_metadata,
    "similarity_scores": similarity_list
}

# Save to JSON
with open("book_data.json", "w") as f:
    json.dump(data, f)



# import json
import html

# Load your JSON file
with open('book_data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Clean each title
cleaned_titles = []
for title in data["book_titles"]:
    # Unescape HTML entities (like &amp; -> &)
    title = html.unescape(title)

    # Strip any extra quotation marks or escape characters
    title = title.replace('\\"', '"').replace("\\'", "'").strip()

    cleaned_titles.append(title)

# Replace the old list
data["book_titles"] = cleaned_titles

# Save cleaned JSON
with open('book_data_cleaned.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print("Cleaned JSON saved to book_data_cleaned.json")
