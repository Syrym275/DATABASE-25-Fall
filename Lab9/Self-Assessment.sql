1.
A - suppose transfer 100 tg from a account and update that row
if the update fails, transaction fails as well
C - if the balance doen't have enough money, it won't go negative
and the data is keeped proper
I - you can't transfer from the same account twice with no enough money
it will stop you
D - if a server or a bank crashes, the money is saved anyways

2.
Commit makes changes permanent, while rollback undoes everything

3.
When you need some transactions to be kept and later ones to be undone

4. 
SERIALIZABLE - strongest, as if transactions executed one at a time
REPEATABLE READ - all statements and queries see the same snapshot
READ COMMITTED - default, sees the latest commited data, prevents dirty reads
READ UNCOMMITTED - lowest isolation, might allow dirty reads, highest concurrency

5.
when you read something that is rolled back right away, read uncommited might allow this

6.
A non-repeatable read occurs when a transaction reads the same row twice, but gets different values
For example if you have an update statement running concurrently to two select queries

7.
a phantom read is when some updates occur in between SELECT queries
repeatable read amd serializied isolation level will prevent that

8.
When you don't need all the blockings of serialized and want to save on high throughput

9.
It bases on ACID
It is isolated and appears as if only one process executes at a time
It prevents some errors by different isolation levels.


10.
If the database system crashes, uncommitted changes are automatically lost.
Because they never been made permanent by commit.


Summary: Transactions ensure that database operations are executed safely and reliably, preserving consistency, isolation, and durability even under concurrency or failures.
*/
