<?xml version="1.0" encoding="utf-8"?>

<!-- Assignment 3 (Task 4 XSLT) by Ethan Dakin (8209194) -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">

    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <title>DPIT128: Assignment 3 (Task 4 XSLT)</title>
        <style>

          /* BEGIN: Template CSS (DO NOT ALTER/REMOVE) ----------- */

          body {
            background-color: #ededed;
            text-align: center;
          }

          table {
            margin-left: auto;
            margin-right: auto;
          }

          /* END: Template CSS (DO NOT ALTER/REMOVE) ------------- */

          /* INSERT INTERNAL CSS HERE */

          <!-- Table, td and th border specifications -->
          table, td, th {
            border: 1px solid #808080;
            border-collapse: collapse;
          }

          <!-- Background color for th elements -->
          th {
            background-color: #b9b9b9;
          }

          <!-- Padding and font size for all th and td elements -->
          th, td {
            padding: 10px;
            font-size: 20px;
          }

          <!-- Shading for all even rows. -->
          tr:nth-child(even) {
            background-color: #e0e0e0;
          }

          <!-- Alignment for all numerical columns -->
          .numerical-align {
            text-align: center;
          }


        </style>
      </head>
      <body>
        <h1>DPIT128: Assignment 3</h1>
        <h2>Ethan Dakin (8209194)</h2>
        <h3>Date Due: 08/12/2023</h3>
        <hr />
        <p style="font-weight: bold;">
          I have viewed the College&apos;s policy regarding Academic Integrity as provided at the following URL:<br />
          <a href="https://www.uowcollege.edu.au/site-assets/uow-college-australia/documents/16-02-2023-Academic-Integrity-and-Student-Conduct-Policy.pdf" target="_blank">
            https://www.uowcollege.edu.au/site-assets/uow-college-australia/documents/16-02-2023-Academic-Integrity-and-Student-Conduct-Policy.pdf
          </a>
        </p>
        <hr />
        <h2>Task 4 XSLT</h2>

        <!-- BEGIN: Task 4 Solution -->
        <!-- Variable for URL-->
        <xsl:variable name="url" select="comparisons/@url"/>

        <!-- Variables for date, they are all split strings of the main date string, aligned in a way that fits the australian date specifications.-->
        <xsl:variable name="date-year" select="substring(comparisons/@dated, 1, 4)" />
        <xsl:variable name="date-month" select="substring(comparisons/@dated, 6, 2)" />
        <xsl:variable name="date-day" select="substring(comparisons/@dated, 9, 2)" />
        <xsl:variable name="formatted-date" select="concat($date-day, '/', $date-month, '/', $date-year)" /> 

        <!-- Main heading, with a h2 element -->
        <h2>Hotel Comparison Table</h2>

        <!-- Main table -->
        <table>
          <!-- Caption with a font size of 20, and a bottom padding of 10px, also, with the xsl value of the location in the comparisons element.-->
          <caption style="font-size: 20px; padding-bottom: 10px">Search Location: <xsl:value-of select="comparisons/@location"/></caption>

          <!-- Table header -->
          <thead>
            <!-- Th elements to denote the values for each following row. -->
            <th>Hotel Name</th>
            <th>Star Rating</th>
            <th>Total Reviews</th>
            <th>Overall Score</th>
          </thead>

          <!-- Table body -->
          <tbody>
            <!-- XSL for each loop to go through each element in the comparisons/hotel list -->
            <xsl:for-each select="comparisons/hotel">
              <!-- Table row for hotel -->
              <tr>
                <!-- All following table rows use the xsl value of for the corresponding column-->
                <!-- td element for the name  -->
                <td>
                  <xsl:value-of select="name"/>
                </td>

                <!-- All numerical elements have .numerical-align class applied to them -->
                <!-- td element for the stars  -->
                <td class="numerical-align">
                  <xsl:value-of select="stars"/>
                </td>

                <!-- td element for the reviews  -->
                <td class="numerical-align">
                  <!-- Format number so it has a comma-->
                  <xsl:value-of select="format-number(reviews, '###,###,###')" />
                </td>

                <!-- td element for the score  -->

                <!-- Choose block to decide background colour -->
                <xsl:choose>
                  <!-- When score is greater than 8.5 and score is less than 9.0, have an orange cell-->
                  <xsl:when test="score &gt; 8.5 and score &lt; 9.0">
                    <td style="background-color: #ffdb99"> 
                      <xsl:value-of select="score"/>
                    </td>
                  </xsl:when>

                  <!-- When score is less than 8.5 then have a red cell -->
                  <xsl:when test="score &lt;=8.5">
                    <td style="background-color: #ff9999"> 
                      <xsl:value-of select="score"/>
                    </td>
                  </xsl:when>

                  <!-- Otherwise, have a green cell -->
                  <xsl:otherwise>
                    <td style="background-color: #99cc99"> 
                      <xsl:value-of select="score"/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
              </tr>
            </xsl:for-each>
          </tbody>

        </table>

        <!-- Text shown beneath the table contains the url variable and the formatted date, in a h3 element. -->
        <h3>This information was obtained from <a href="{$url}" target="_blank">Trivago</a> on <xsl:value-of select="$formatted-date" /></h3>

        <!-- END: Task 4 Solution -->

        <p>&#169;Ethan Dakin</p>
      </body>
    </html>

  </xsl:template>

</xsl:stylesheet>