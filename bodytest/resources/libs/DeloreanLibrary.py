import psycopg2
from logging import info
#importar somente o "info" do módulo de logging
class DeloreanLibrary():

    def connect(self):
        return psycopg2.connect(
            host='ec2-34-225-167-77.compute-1.amazonaws.com',
            database='dh6vu2n9mb3lt',
            user='vitwkgdzmockzu',
            password='19af18336b7ddd48582708583e21ea331b0b5d3e7f7ee4e803cf860262e12d62'
        )

    #No Robot vira uma KW automágicamente => Remove Student    email@desejado.com
    ## Students    
    def remove_student(self, email):

        query = "delete from students where email = '{}'".format(email)
        info(query)

        conn = self.connect()

        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()

    def remove_student_by_name(self, name):

        query = "delete from students where name LIKE '%{}%'".format(name)
        info(query)

        conn = self.connect()

        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()

    def insert_student(self, student):

        self.remove_student(student['email'])

        query = ("insert into students (name, email, age, weight, feet_tall, created_at, updated_at)"
                "values('{}','{}',{},{},{},NOW(),NOW());"
                .format(student['name'],student['email'],student['age'],student['weight'],student['feet_tall']))
        info(query)

        conn = self.connect()

        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()


    ## Plans
    def remove_plan_by_name(self, plan):

        query = "delete from plans where title LIKE '%{}%'".format(plan)
        info(query)

        conn = self.connect()

        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()

    def insert_plan(self, plan):

        self.remove_plan_by_name(plan['title'])

        query = ("insert into plans (title,duration,price,created_at,updated_at)"
                "values('{}',{},{},NOW(),NOW());"
                .format(plan['title'],plan['duration'],plan['price']))
        info(query)

        conn = self.connect()

        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()