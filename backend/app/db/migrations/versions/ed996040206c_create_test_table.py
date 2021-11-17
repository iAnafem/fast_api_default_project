"""create_test_table

Revision ID: ed996040206c
Revises: 
Create Date: 2021-11-11 20:52:29.340187

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic
revision = 'ed996040206c'
down_revision = None
branch_labels = None
depends_on = None

test_table = "test_table"


def create_test_table() -> None:
    op.create_table(
        test_table,
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("msg", sa.Text, nullable=False, index=True),
    )


def insert_test_entry() -> None:
    op.execute(
        "INSERT INTO test_table (msg) values ('Hello, db is here!')")


def upgrade() -> None:
    create_test_table()
    insert_test_entry()


def downgrade() -> None:
    pass
    # op.drop_table("test_table")
