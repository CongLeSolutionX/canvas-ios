//
// Copyright (C) 2017-present Instructure, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "CKIClient+CKIQuiz.h"
#import "CKIQuiz.h"
#import "CKICourse.h"

@implementation CKIClient (CKIQuiz)

- (RACSignal *)fetchQuiz:(NSString *)quizID forCourse:(CKICourse *)course
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    path = [path stringByAppendingPathComponent:quizID];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIQuiz class] context:course];
}

- (RACSignal *)fetchQuizzesForCourse:(CKICourse *)course
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIQuiz class] context:course];
}

@end
