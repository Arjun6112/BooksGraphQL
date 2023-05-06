import 'package:graphql_basics/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'book_model.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  // Get all books

  Future<List<BookModel>> getBooks({required int limit}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query(\$limit: Int) {
              getBooks(limit: \$limit) {
                _id
                author
                title
                year
              }
            }
            """),
          variables: {
            'limit': limit,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }
      List? res = result.data?['getBooks'];

      if (res == null || res.isEmpty) {
        return [];
      }

      List<BookModel> books =
          res.map((book) => BookModel.fromMap(map: book)).toList();
      return books;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Delete Book

  Future<bool> deleteBook({required String id}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
            mutation Mutation(\$id: ID!) {
              deleteBook(ID: \$id)
            }
          """),
          variables: {
            "id": id,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  //Creating a book

  Future<bool> createBook(
      {required String title,
      required String author,
      required int year}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
              mutation Mutation(\$bookInput: BookInput) {
                createBook(bookInput: \$bookInput)
              }
            """),
          variables: {
            "bookInput": {
              "title": title,
              "author": author,
              "year": year,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  // Update Book

  Future<bool> updateBook(
      {required String id,
      required String title,
      required String author,
      required int year}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
              mutation Mutation(\$id: ID!, \$bookInput: BookInput) {
                updateBook(ID: \$id, bookInput: \$bookInput)
              }
            """,
          ),
          variables: {
            "id": id,
            "bookInput": {
              "title": title,
              "author": author,
              "year": year,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
