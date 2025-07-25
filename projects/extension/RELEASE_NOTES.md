# Pgai extension release notes

## 0.11.0 (2025-07-10)

Enable bedrock embedding via liteLLM.

## 0.10.1 (2025-04-24)

Patch release to fix cloud extension update issues when using the `postgres` user.

### Fixes

- fix cloud extension update issues when using the `postgres` user (#647) ([ad46c71](https://github.com/timescale/pgai/commit/ad46c71))

## 0.10.0 (2025-04-23)

This release contains a major breaking change. The vectorizer code has been
removed from the extension and put into the [pgai python
library](/projects/pgai/README.md). We did this to allow the vectorizer
functionality to be used on more PostgreSQL cloud providers (AWS RDS, Supabase,
etc.)

We made this change in a way that will allow current users of the vectorizer to
continue using the feature without interruption, but they will have to modify how they
upgrade vectorizer functionality in the future.

**Upgrading vectorizer functionality to 0.10.0:**

1. Run `ALTER EXTENSION name UPDATE TO '0.10.0'` to detach the vectorizer catalog tables and functions from the extension. This leaves them in your database in the ai schema, and the vectorizer will continue to work.
2. You can then manage them from the python library or cli by upgrading the vectorizer with `pgai install -d DB_URL` as described in the new python-library-based [workflow](/docs/vectorizer/api-reference.md#install-or-upgrade-the-database-objects-necessary-for-vectorizer).
3. If you don't use the model calling capabilities of pgai, you can then remove the pgai extension from your database.

### New features and improvements

Split extension into an extension and a library package (#580) ([3fe83c6](https://github.com/timescale/pgai/commit/3fe83c6))

### Fixes

fix: send top level destination fields in updateembeddings request (#629) ([ee4f383](https://github.com/timescale/pgai/commit/ee4f383))
chore: update anthropic and openai libraries in extension (#595) ([d31ef9c](https://github.com/timescale/pgai/commit/d31ef9c))

## 0.9.0 (2025-03-06)

### New features and improvements

- [BREAKING] Add openai client config arguments ([#426](https://github.com/timescale/pgai/pull/426))
- Add support for openai extra request parameteres ([#420](https://github.com/timescale/pgai/pull/420))
- Add verbose flag to model calls ([#475](https://github.com/timescale/pgai/pull/475))
- Add chunking functions to the extension ([#418](https://github.com/timescale/pgai/pull/418))
- Add raw response variants for openai function ([#422](https://github.com/timescale/pgai/pull/422))

### Fixes

- Remove foreign key to embedding table and make the trigger handle deletes instead. This allows updating primary keys on the source table, in the case of not using surrogate keys. ([#485](https://github.com/timescale/pgai/pull/485))
- Use format_type to get primary key data types to support more types. ([#497](https://github.com/timescale/pgai/pull/497))
- Allow reasoning models (o1, o3) to work with chat completion ([#416](https://github.com/timescale/pgai/pull/416))

## 0.8.0 (2025-02-04)

### New features and improvements

- Add vectorizer enable/disable support for `ai.scheduling_none` ([#402](https://github.com/timescale/pgai/pull/402))
- Add LiteLLM embedding and vectorizer integration ([#320](https://github.com/timescale/pgai/pull/320))
- Add Ollama support for tool use and structured outputs ([#403](https://github.com/timescale/pgai/pull/403))
- [BREAKING] Update cohere embed, chat, rerank to use V2 endpoints ([#417](https://github.com/timescale/pgai/pull/417))
- Add `ai.anthropic_list_models` ([#386](https://github.com/timescale/pgai/pull/386))

### Fixes

- Changed tool_choice type and null args omitted ([#405](https://github.com/timescale/pgai/pull/405))

### Other improvements

- Update anthropic library to 0.44.0 ([#385](https://github.com/timescale/pgai/pull/385))
- Improve and split DEVELOPMENT.md ([#380](https://github.com/timescale/pgai/pull/380))

## 0.7.0 (2025-01-15)

### New features and improvements

- Allow users to configure a base_url for the vectorizer OpenAI embedder ([66ceb3d](https://github.com/timescale/pgai/commit/66ceb3d))
- Upgrade ollama client to 0.4.5 ([c579238](https://github.com/timescale/pgai/commit/c579238))
- Add just ext docker-start command ([96ac4f5](https://github.com/timescale/pgai/commit/96ac4f5))
- Allow vectorizers to be granted to public ([7b2995b](https://github.com/timescale/pgai/commit/7b2995b))
- Allow superusers to create vectorizers on any table ([027b3f4](https://github.com/timescale/pgai/commit/027b3f4))

### Fixes

- Fix load_datasets to handle structs ([25465ae](https://github.com/timescale/pgai/commit/25465ae))
- Fix deprecation warning on re.split ([7b4a916](https://github.com/timescale/pgai/commit/7b4a916))
- Fix exclude python system packages for versioned extension ([1f6d1a8](https://github.com/timescale/pgai/commit/1f6d1a8))
- Fix schema qualify type definitions, casts, and operators ([ee86d35](https://github.com/timescale/pgai/commit/ee86d35))
- Fix host networking not supported on macOS ([aac3d83](https://github.com/timescale/pgai/commit/aac3d83))
- Fix handling of empty `PG_BIN` ([bd83165](https://github.com/timescale/pgai/commit/bd83165))

### Other improvements

- Add warning when trying to install pre-release version ([0b400a0](https://github.com/timescale/pgai/commit/0b400a0))
- Support uv in extension install for development ([3f9736a](https://github.com/timescale/pgai/commit/3f9736a))

## 0.6.0 (2024-12-10)

This release adds support for using Voyage AI in a vectorizer, and loading
datasets from hugging face.

### New features and improvements

- Use the `ai.voyageai_embed`, and `ai.embedding_voyageai` functions to use Voyage AI for vector embeddings 1b56d62295faf996697db75f3a9ac9391869a3bb.
- Add `ai.load_dataset` to load datasets from hugging face 29469388f22d15ae79e293f8151ef0a730820b3c.
- Change the type of `keep_alive` parameter from `float8` to `text` 0c747418efc70d656330f605195bf0d2c164bec2
- Remove `truncate` parameter from Ollama/Voyage APIs ecda03cf5d27f750db534801719413d0abcfa557

### Fixes

- Fix Anthropic tool use 2cb2fe9c55f44da82e605a47194428a11f77f9de.

## 0.5.0 (2024-11-26)

This release adds support for using Ollama in a vectorizer, and fixes a bug
introduced in 0.4.1.

### New features and improvements

- Use the `ai.embedding_ollama` function to configure a vectorizer to use an Ollama API 6a4a449e99e2e5e62b5f551206a0b28e5ad40802.

### Fixes

- Allow members of source table to create vectorizer 39537792048b64049b252ee11f1236b906e0b726.

## 0.4.1 (2024-11-19)

This release focuses on improving reliability, performance, and maintainability
while fixing several important edge cases in table management and permissions.

### New features and improvements

- Various improvements to build tooling
- Based on prior benchmarking, using storage plain (rather than extended/external) for vector columns
  performs much better. Unfortunately, it is difficult to determine whether a target table row will
  definitively fit on a single postgres page. Therefore, we will assign storage main to the vector
  columns, which will keep them inline unless they won't fit and toast otherwise.
  NOTE: We will set storage to main for existing vectorizers (unless they have been already manually
  set to main or plain), but this will not take effect until a table rewrite happens. This can be
  done with `CLUSTER` or `VACUUM FULL` and may take a while depending on the size of the table.
  c64f2403219788a42d981b3ee299530bbd9a94e4
- Dropping the source table with cascade will drop the target too 644858dd685f897ba28f509562773f1d475f1b9e
- Added entries into pg_depend such that when you `drop table <source-table> cascade` or
  `drop table <target-table> cascade` it will also drop the queue table for
  vectorizers. f68e73ac5e82f41b4bcd25a0976daef889b34d1f
- Created a more thorough snapshot in upgrade tests 2b330a4ea732ef94d00808a24d96c43c846dfa6b
- Added a vectorizer and secret to upgrade tests a1d4104cf798de84a85189aaccf3a0af9bc17b93
- Added a test to ensure ai.secret_permissions is dumped/restored properly. 5a9bfd1fb1b415c38e2a60430dac9762cb59de5a
- Added cache for secrets 20809c16745540bd8bc21a546f0d0b7ec912549e
- Allowed drop_vectorizer to optionally drop target and view ec53befe9151a2d0091de53ace068b8ea2f12573
- Added an api_key_name parameter to allow functions to remain immutable while
  getting a secret. This avoids having to use ai.reveal_secret() which is stable
  and not immutable. This allows for more efficient queries when getting a secret
  that is not the one with a default query. 59b86d66f92840eed49f80e9ebdcf4f0c60475bd
- Made reveal_secrets stable f2e0e1489f2ac30f824db7ff137e1252463bddb1
- Added an event trigger to detect when a source, queue, or target table associated
  with a vectorizer is dropped. The event trigger calls ai.drop_vectorizer to
  clean up the mess. a01e6208e81942b289970feebfc96bafb95c3fcc
- Allowed SQL to be gated behind feature flags. This commit added support for building
  and shipping prerelease SQL code gated behind feature flags in extension versions
  that include a prerelease tag. Prerelease SQL code is omitted entirely from
  extension versions that do not include a prerelease tag. For details, see
  DEVELOPMENT.md d2bcbfaa83f424d9b8d6894d4d206be8f84ab8d6
- Added tests to check that extension upgrades work d2bcbfaa83f424d9b8d6894d4d206be8f84ab8d6

### Fixes

- Made ai.secret_permissions dump/restore properly. Two rows are inserted into
  ai.secret_permissions on extension creation. If these rows are dumped, then on
  restore the extension creation inserts them AND the table restoration tries to insert them.
  This causes a constraint violation and prevents the table from restoring properly.
  This commit added a filter to prevent the two rows from being dumped. 39d61db97e85f61441dbe2eafa2bee209bc797fd
- Prevent vectorizer status view from failing if missing privileges to one or more
  vectorizer queue tables 44ea1cb0f92b294284ae252fd179191d83145d5c
- Handle dropped columns when creating vectorizers 814f0ba5a27d69f839c7c8232b118a7a4d0e6772
- Avoid inserting duplicates into ai.\_secret_permissions. This fixes an issue that
  would cause upgrade to fail. ec2363a9f55cc25ce1295526c9f90d9446edd97b

### Breaking changes

- Previously, the vectorizer_queue_pending function would return an exact count which could be very
  slow for queues with a large number of rows. Now, by default, we limit the count to 10000 by
  default. An `exact_count` parameter was added. If true, the original behavior is used.
  c11db9c2d7fb8346f28f4de17bf3706e9d1620d4
- If a vectorizer has no queue table, or the user does not have select privileges on the queue table
  we will now return null for the pending_items column in the vectorizer_status view.
  f17d1b908df9fd7072b5554de7dc162102a5611b

### Deprecations

- Versions `0.1.0`, `0.2.0`, and `0.3.0` are deprecated and will be removed in a future release.
  To upgrade from a deprecated version, you must `DROP EXTENSION ai` and then `CREATE EXTENSION ai VERSION '0.4.1' CASCADE`.

## 0.4.0 (2024-10-23)

This release adds the [Vectorizer](/docs/vectorizer/overview.md) feature to the extension. Vectorizer is an
innovative SQL-level interface for automating the embedding process within
the database. Vectorizer treats embeddings as a declarative, DDL-like feature, similar to
an index. For more details, check out the [documentation](/docs/vectorizer/overview.md).

### New features and improvements

- Added the Vectorizer feature.
- Added support for the `rank_fields` parameter to the `cohere_rerank` function.
- Added support for the `base_url` parameter to the OpenAI functions.
- Various functions were changed from `volatile` to `immutable` for performance.
- Added `ai.openai_chat_complete_simple` function.

### Breaking changes

- There are no update paths from 0.1.0, 0.2.0, 0.3.0 to the 0.4.0 release. You
  must `DROP EXTENSION ai` and then `CREATE EXTENSION ai VERSION '0.4.0' CASCADE`.
- The pgai extension is now installed in the `ai` schema. It was previously
  installed in the `public` schema by default, but could be explicitly put in
  another schema. All pgai functions have moved to the `ai` schema. For example,
  `openai_list_models()` is now `ai.openai_list_models()`
- The `pg_database_owner` and the database user running `CREATE EXTENSION` now get
  admin privileges over the extension. Other database users and roles need to
  be granted privileges to use the extension. You do this using [functions](/projects/extension/docs/security/privileges.md).
- The parameter names to the openai*, ollama*, anthropic*, and cohere* functions
  were renamed to remove underscore prefixes and conflicts with reserved and
  non-reserved keywords.
