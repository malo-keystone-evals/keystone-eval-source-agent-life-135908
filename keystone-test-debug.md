# keystone-dev test — execution trace

2 case(s) traced.

---

## books/review_digest :: an_unreviewed_book_has_nothing_to_digest — PASS

run_id: `81b9e9cb-b416-4535-94f6-970ac962df17`

### Steps (execution order)

#### 1. node `entry` — Done

- incoming: _entry — trigger input_

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "id": "74ae41ed-302f-5958-bf3e-0d28546642d3",
      "status": "published",
      "title": "Dune",
      "author_id": "050ca010-afa3-5126-b4a3-ef3deab5ad94",
      "author_name": "Frank Herbert",
      "co_author_ids": [
        "dummy"
      ],
      "summary": "dummy",
      "cover_description": "dummy",
      "webhook_secret": "dummy",
      "slug": "dummy",
      "isbn": "DUMMY",
      "genre": "fiction",
      "blurb_budget_usd": 0,
      "agent_cost_microcents": 0,
      "page_count": 0,
      "price_cents": 0,
      "published_on": "dummy",
      "cover_url": "dummy",
      "cover_image_id": "dummy",
      "featured": false,
      "review_count": 0,
      "rating_total": 0,
      "average_rating": 0.0,
      "reviews_at_shelving": 0,
      "board_rank": "dummy",
      "author_identity": null,
      "created_at": "2026-01-01T00:00:00+00:00",
      "updated_at": "2026-01-01T00:00:00+00:00",
      "created_by_id": null,
      "updated_by_id": null
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "id": "74ae41ed-302f-5958-bf3e-0d28546642d3",
    "status": "published",
    "title": "Dune",
    "author_id": "050ca010-afa3-5126-b4a3-ef3deab5ad94",
    "author_name": "Frank Herbert",
    "co_author_ids": [
      "dummy"
    ],
    "summary": "dummy",
    "cover_description": "dummy",
    "webhook_secret": "dummy",
    "slug": "dummy",
    "isbn": "DUMMY",
    "genre": "fiction",
    "blurb_budget_usd": 0,
    "agent_cost_microcents": 0,
    "page_count": 0,
    "price_cents": 0,
    "published_on": "dummy",
    "cover_url": "dummy",
    "cover_image_id": "dummy",
    "featured": false,
    "review_count": 0,
    "rating_total": 0,
    "average_rating": 0.0,
    "reviews_at_shelving": 0,
    "board_rank": "dummy",
    "author_identity": null,
    "created_at": "2026-01-01T00:00:00+00:00",
    "updated_at": "2026-01-01T00:00:00+00:00",
    "created_by_id": null,
    "updated_by_id": null
  }
]
```

#### 2. node `reviews` — Done

- incoming from `entry`:
  - filters: none
  - transform: {"steps":[{"kind":"where","property":"book_id","equals":".id"},{"kind":"where","property":"status","equals":"\"published\""},{"kind":"copy","from":".title","to":".context.book_title"}]}

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "filters": [
        {
          "kind": "single",
          "property": "book_id",
          "values": [
            "74ae41ed-302f-5958-bf3e-0d28546642d3"
          ]
        },
        {
          "kind": "single",
          "property": "status",
          "values": [
            "published"
          ]
        }
      ],
      "context": {
        "book_title": "Dune"
      }
    }
  ]
}
```

- output (0 item(s)):
```json
[]
```

#### 3. node `nothing_to_digest` — Done

- incoming from `reviews`:
  - filters: none
  - transform: none

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "context": {
        "book_title": "Dune"
      }
    }
  ]
}
```

- output (0 item(s)):
```json
[]
```

#### 4. node `gather` — Done

- incoming: _entry — trigger input_

- input:
```json
{
  "offset": 0,
  "items": []
}
```

- output (1 item(s)):
```json
[
  {
    "result": []
  }
]
```

#### 5. node `post` — Done

- incoming from `gather`:
  - filters: none
  - transform: {"steps":[{"kind":"copy","from":".result.map({$x => $x.review})","to":".reviews"}]}

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "reviews": []
    }
  ]
}
```

- output (0 item(s)):
```json
[]
```

### Runtime errors

- `nothing_to_digest` item 0: nobody has reviewed Dune yet

- `post` item 0: Error evaluating 'from' selector 'object("book", .context.book_title, "count", .reviews.count(), "loved_by", .reviews.filter({$r => $r.tone.eq("praise")}).map({$r => $r.reviewer}))': missing property context

### Assertion failures

none

---

## books/review_digest :: the_digest_names_who_loved_it — FAIL

run_id: `f0ee0c60-ced1-4191-bdb9-a46246925fc0`

### Steps (execution order)

#### 1. node `entry` — Done

- incoming: _entry — trigger input_

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "id": "74ae41ed-302f-5958-bf3e-0d28546642d3",
      "status": "published",
      "title": "Dune",
      "author_id": "050ca010-afa3-5126-b4a3-ef3deab5ad94",
      "author_name": "Frank Herbert",
      "co_author_ids": [
        "dummy"
      ],
      "summary": "dummy",
      "cover_description": "dummy",
      "webhook_secret": "dummy",
      "slug": "dummy",
      "isbn": "DUMMY",
      "genre": "fiction",
      "blurb_budget_usd": 0,
      "agent_cost_microcents": 0,
      "page_count": 0,
      "price_cents": 0,
      "published_on": "dummy",
      "cover_url": "dummy",
      "cover_image_id": "dummy",
      "featured": false,
      "review_count": 0,
      "rating_total": 0,
      "average_rating": 0.0,
      "reviews_at_shelving": 0,
      "board_rank": "dummy",
      "author_identity": null,
      "created_at": "2026-01-01T00:00:00+00:00",
      "updated_at": "2026-01-01T00:00:00+00:00",
      "created_by_id": null,
      "updated_by_id": null
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "id": "74ae41ed-302f-5958-bf3e-0d28546642d3",
    "status": "published",
    "title": "Dune",
    "author_id": "050ca010-afa3-5126-b4a3-ef3deab5ad94",
    "author_name": "Frank Herbert",
    "co_author_ids": [
      "dummy"
    ],
    "summary": "dummy",
    "cover_description": "dummy",
    "webhook_secret": "dummy",
    "slug": "dummy",
    "isbn": "DUMMY",
    "genre": "fiction",
    "blurb_budget_usd": 0,
    "agent_cost_microcents": 0,
    "page_count": 0,
    "price_cents": 0,
    "published_on": "dummy",
    "cover_url": "dummy",
    "cover_image_id": "dummy",
    "featured": false,
    "review_count": 0,
    "rating_total": 0,
    "average_rating": 0.0,
    "reviews_at_shelving": 0,
    "board_rank": "dummy",
    "author_identity": null,
    "created_at": "2026-01-01T00:00:00+00:00",
    "updated_at": "2026-01-01T00:00:00+00:00",
    "created_by_id": null,
    "updated_by_id": null
  }
]
```

#### 2. node `reviews` — Done

- incoming from `entry`:
  - filters: none
  - transform: {"steps":[{"kind":"where","property":"book_id","equals":".id"},{"kind":"where","property":"status","equals":"\"published\""},{"kind":"copy","from":".title","to":".context.book_title"}]}

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "filters": [
        {
          "kind": "single",
          "property": "book_id",
          "values": [
            "74ae41ed-302f-5958-bf3e-0d28546642d3"
          ]
        },
        {
          "kind": "single",
          "property": "status",
          "values": [
            "published"
          ]
        }
      ],
      "context": {
        "book_title": "Dune"
      }
    }
  ]
}
```

- output (2 item(s)):
```json
[
  {
    "includes": {
      "book": {
        "id": "74ae41ed-302f-5958-bf3e-0d28546642d3",
        "status": "published",
        "title": "Dune"
      },
      "member": {
        "id": "18efe28f-3fe5-516e-a8fc-7143a99392de",
        "status": "active",
        "display_name": "Alice R.",
        "membership_tier": "bronze"
      }
    },
    "review": {
      "id": "6708578c-0575-5278-a058-8906703725a7",
      "status": "published",
      "book_id": "74ae41ed-302f-5958-bf3e-0d28546642d3",
      "member_id": "18efe28f-3fe5-516e-a8fc-7143a99392de",
      "rating": 5,
      "headline": "Wonderful",
      "body": "dummy",
      "recommended": true,
      "tags": [
        "dummy"
      ],
      "book_identity": null,
      "member_identity": null,
      "created_at": "2026-01-01T00:00:00+00:00",
      "updated_at": "2026-01-01T00:00:00+00:00",
      "created_by_id": null,
      "updated_by_id": null
    },
    "context": {
      "book_title": "Dune"
    }
  },
  {
    "includes": {
      "book": {
        "id": "74ae41ed-302f-5958-bf3e-0d28546642d3",
        "status": "published",
        "title": "Dune"
      },
      "member": {
        "id": "3200fd13-1ba1-59e6-a7be-b2038b055437",
        "status": "active",
        "display_name": "Bob K.",
        "membership_tier": "bronze"
      }
    },
    "review": {
      "id": "9b6be209-8263-5ee9-9b31-3e11fe8f527e",
      "status": "published",
      "book_id": "74ae41ed-302f-5958-bf3e-0d28546642d3",
      "member_id": "3200fd13-1ba1-59e6-a7be-b2038b055437",
      "rating": 2,
      "headline": "Too long",
      "body": "dummy",
      "recommended": true,
      "tags": [
        "dummy"
      ],
      "book_identity": null,
      "member_identity": null,
      "created_at": "2026-01-01T00:00:00+00:00",
      "updated_at": "2026-01-01T00:00:00+00:00",
      "created_by_id": null,
      "updated_by_id": null
    },
    "context": {
      "book_title": "Dune"
    }
  }
]
```

#### 3. node `tone` — Done

- incoming from `reviews`:
  - filters: none
  - transform: {"steps":[{"kind":"copy","from":".review.rating","to":".rating"},{"kind":"copy","from":".includes.member.display_name","to":".context.reviewer"}]}

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "rating": 5,
      "context": {
        "reviewer": "Alice R.",
        "book_title": "Dune"
      }
    },
    {
      "rating": 2,
      "context": {
        "reviewer": "Bob K.",
        "book_title": "Dune"
      }
    }
  ]
}
```

- output (0 item(s)):
```json
[]
```

#### 4. node `entry` — Done

- incoming: _entry — trigger input_

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "rating": 5
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "rating": 5
  }
]
```

#### 5. node `entry` — Done

- incoming: _entry — trigger input_

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "rating": 2
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "rating": 2
  }
]
```

#### 6. node `gather` — Done

- incoming: _entry — trigger input_

- input:
```json
{
  "offset": 0,
  "items": []
}
```

- output (1 item(s)):
```json
[
  {
    "result": []
  }
]
```

#### 7. node `classify` — Done

- incoming from `entry`

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "rating": 5
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "rating": 5
  }
]
```

#### 8. node `classify` — Done

- incoming from `entry`

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "rating": 2
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "rating": 2
  }
]
```

#### 9. node `post` — Done

- incoming from `gather`:
  - filters: none
  - transform: {"steps":[{"kind":"copy","from":".result.map({$x => $x.review})","to":".reviews"}]}

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "reviews": []
    }
  ]
}
```

- output (0 item(s)):
```json
[]
```

#### 10. node `answer` — Done

- incoming from `classify`

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "tone": "praise"
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "tone": "praise"
  }
]
```

#### 11. node `answer` — Done

- incoming from `classify`

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "tone": "complaint"
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "tone": "complaint"
  }
]
```

#### 12. node `tone` — Done

- incoming from `tone`

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "rating": 5,
      "context": {
        "reviewer": "Alice R.",
        "book_title": "Dune"
      },
      "__call": {
        "returned": {
          "tone": "praise"
        }
      }
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "tone": "praise",
    "context": {
      "reviewer": "Alice R.",
      "book_title": "Dune"
    }
  }
]
```

#### 13. node `tone` — Done

- incoming from `tone`

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "rating": 2,
      "context": {
        "reviewer": "Bob K.",
        "book_title": "Dune"
      },
      "__call": {
        "returned": {
          "tone": "complaint"
        }
      }
    }
  ]
}
```

- output (1 item(s)):
```json
[
  {
    "tone": "complaint",
    "context": {
      "reviewer": "Bob K.",
      "book_title": "Dune"
    }
  }
]
```

#### 14. node `gather` — Done

- incoming from `tone`:
  - filters: none
  - transform: {"steps":[{"kind":"copy","from":"object(\"tone\", .tone, \"reviewer\", .context.reviewer)","to":".review"}]}

- input:
```json
{
  "offset": 0,
  "items": [
    {
      "review": {
        "tone": "praise",
        "reviewer": "Alice R."
      },
      "context": {
        "reviewer": "Alice R.",
        "book_title": "Dune"
      }
    },
    {
      "review": {
        "tone": "complaint",
        "reviewer": "Bob K."
      },
      "context": {
        "reviewer": "Bob K.",
        "book_title": "Dune"
      }
    }
  ]
}
```

- output (1 item(s)):
```json
[
  [
    {
      "review": {
        "tone": "praise",
        "reviewer": "Alice R."
      },
      "context": {
        "reviewer": "Alice R.",
        "book_title": "Dune"
      }
    },
    {
      "review": {
        "tone": "complaint",
        "reviewer": "Bob K."
      },
      "context": {
        "reviewer": "Bob K.",
        "book_title": "Dune"
      }
    }
  ]
]
```

#### 15. node `gather` — Done

- incoming: _entry — trigger input_

- input:
```json
{
  "offset": 0,
  "items": []
}
```

- output: _none_

### Runtime errors

- `post` item 0: Error evaluating 'from' selector 'object("book", .context.book_title, "count", .reviews.count(), "loved_by", .reviews.filter({$r => $r.tone.eq("praise")}).map({$r => $r.reviewer}))': missing property context

### Assertion failures

- call::post
  - expected: {"body":{"book":"Dune","count":2,"loved_by":["Alice R."]}}
  - recorded: 0 call(s)
