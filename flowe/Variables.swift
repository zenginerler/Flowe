//
//  Variables.swift
//  flowe
//
//  Created by Hiran Manoharan on 11/26/21.
//

import Foundation
import UIKit
import CoreData

class Variables: UIViewController {
    // Username string variable
    static var username = ""
    static var userID:NSManagedObjectID? = nil
    static var firstName = "New User"
    
    // Color Variables
    static let userTheme = "appTheme"
    static var appTheme = 1 // Default app theme = .light
    static let defaults = UserDefaults.standard
    
    // remove project variable
    static var removeProject = false
    
    // delete project variable
    static var deleteProject = false
    
    // Animation avatar
    static var avatar = "sun"
    
    // sound for home launch
    static var sound = (Variables.defaults.string(forKey: "appSound") ?? "bells")
    
    static var isMuted = false
    
    static var quotes =
    [
        ["Life isn’t about getting and having, it’s about giving and being.","Kevin Kruse"],
        
        ["Whatever the mind of man can conceive and believe, it can achieve.","Napoleon Hill"],
        
        ["Strive not to be a success, but rather to be of value.","Albert Einstein"],
        
        ["Two roads diverged in a wood, and I—I took the one less traveled by, And that has made all the difference.","Robert Frost"],
        
        ["I attribute my success to this: I never gave or took any excuse.","Florence Nightingale"],
        
        ["You miss 100% of the shots you don’t take.","Wayne Gretzky - Michael Scott"],
        
        ["The most difficult thing is the decision to act, the rest is merely tenacity.","Amelia Earhart"],
        
        ["Every strike brings me closer to the next home run.","Babe Ruth"],
        
        ["Definiteness of purpose is the starting point of all achievement.","W. Clement Stone"],
        
        ["We must balance conspicuous consumption with conscious capitalism.","Kevin Kruse"],
        
        ["Life is what happens to you while you’re busy making other plans.","John Lennon"],
        
        ["We become what we think about.","Earl Nightingale"],
        
        ["Life is 10% what happens to me and 90% of how I react to it.","Charles Swindoll"],
        
        ["The most common way people give up their power is by thinking they don’t have any.","Alice Walker"],
        
        ["The mind is everything. What you think you become.","Buddha"],
        
        ["The best time to plant a tree was 20 years ago. The second best time is now.","Chinese Proverb"],
        
        ["An unexamined life is not worth living.","Socrates"],
        
        ["Eighty percent of success is showing up.","Woody Allen"],
        
        ["Your time is limited, so don’t waste it living someone else’s life.","Steve Jobs"],
        
        ["Winning isn’t everything, but wanting to win is.","Vince Lombardi"],
        
        ["I am not a product of my circumstances. I am a product of my decisions.","Stephen Covey"],
        
        ["Every child is an artist.  The problem is how to remain an artist once he grows up.","Pablo Picasso"],
        
        ["I’ve learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel.","Maya Angelou"],
        
        ["Either you run the day, or the day runs you.","Jim Rohn"],
        
        ["Whether you think you can or you think you can’t, you’re right.","Henry Ford"],
        
        ["The two most important days in your life are the day you are born and the day you find out why.","Mark Twain"],
        
        ["Whatever you can do, or dream you can, begin it.  Boldness has genius, power and magic in it.","Johann Wolfgang von Goethe"],
        
        ["The best revenge is massive success.","Frank Sinatra"],
        
        ["People often say that motivation doesn’t last. Well, neither does bathing.  That’s why we recommend it daily.","Zig Ziglar"],
        
        ["Life shrinks or expands in proportion to one’s courage.","Anais Nin"],
    
        ["If you hear a voice within you say “you cannot paint,” then by all means paint and that voice will be silenced.","Vincent Van Gogh"],
        
        ["There is only one way to avoid criticism: do nothing, say nothing, and be nothing.","Aristotle"]
    ]
}
