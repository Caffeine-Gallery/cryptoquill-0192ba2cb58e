import Int "mo:base/Int";
import Text "mo:base/Text";

import Time "mo:base/Time";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";

actor {
    // Post type definition
    public type Post = {
        title: Text;
        body: Text;
        author: Text;
        timestamp: Int;
    };

    // Store posts in a stable variable
    private stable var posts : [Post] = [];
    
    // Create a new post
    public shared func createPost(title: Text, body: Text, author: Text) : async Post {
        let newPost : Post = {
            title = title;
            body = body;
            author = author;
            timestamp = Time.now();
        };
        
        posts := Array.append<Post>([newPost], posts);
        return newPost;
    };

    // Get all posts sorted by timestamp (newest first)
    public query func getPosts() : async [Post] {
        Array.sort<Post>(posts, func(a, b) {
            if (a.timestamp > b.timestamp) { #less }
            else if (a.timestamp < b.timestamp) { #greater }
            else { #equal }
        })
    };
}
