package hbcms.test;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.transaction.TransactionConfiguration;

@ContextConfiguration(locations = { "classpath*:spring-context.xml"})
@TransactionConfiguration(transactionManager = "transactionManager")
public abstract class AbstractTransactionalTests extends AbstractTransactionalJUnit4SpringContextTests {


}
